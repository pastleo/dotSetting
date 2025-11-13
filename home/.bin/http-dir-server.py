#!/usr/bin/env python3

import http.server
import os
import urllib.parse
import html
import io
import sys
from http import HTTPStatus

class HTTPRequestHandler(http.server.SimpleHTTPRequestHandler):
    def end_headers(self):
        self.send_my_headers()
        http.server.SimpleHTTPRequestHandler.end_headers(self)

    def send_my_headers(self):
        self.send_header("Cache-Control", "no-cache, no-store, must-revalidate")
        self.send_header("Pragma", "no-cache")
        self.send_header("Expires", "0")

    def list_directory(self, path):
        """Helper to produce a directory listing with upload form."""
        try:
            list = os.listdir(path)
        except OSError:
            self.send_error(
                HTTPStatus.NOT_FOUND,
                "No permission to list directory")
            return None
        list.sort(key=lambda a: a.lower())
        r = []
        displaypath = self.path
        displaypath = displaypath.split('#', 1)[0]
        displaypath = displaypath.split('?', 1)[0]
        try:
            displaypath = urllib.parse.unquote(displaypath,
                                               errors='surrogatepass')
        except UnicodeDecodeError:
            displaypath = urllib.parse.unquote(displaypath)
        displaypath = html.escape(displaypath, quote=False)
        enc = sys.getfilesystemencoding()
        title = f'Directory listing for {displaypath}'
        r.append('<!DOCTYPE HTML>')
        r.append('<html lang="en">')
        r.append('<head>')
        r.append(f'<meta charset="{enc}">')
        r.append('<style type="text/css">\n:root {\ncolor-scheme: light dark;\n}\n</style>')
        r.append(f'<title>{title}</title>\n</head>')
        r.append(f'<body>\n<h1>{title}</h1>')
        r.append('<hr>\n<ul>')
        for name in list:
            fullname = os.path.join(path, name)
            displayname = linkname = name
            # Append / for directories or @ for symbolic links
            if os.path.isdir(fullname):
                displayname = name + "/"
                linkname = name + "/"
            if os.path.islink(fullname):
                displayname = name + "@"
                # Note: a link to a directory displays with @ and links with /
            r.append('<li><a href="%s">%s</a></li>'
                    % (urllib.parse.quote(linkname,
                                          errors='surrogatepass'),
                       html.escape(displayname, quote=False)))
        r.append('</ul>\n<hr>')
        r.append('<h2>Upload File</h2>')
        r.append('<form enctype="multipart/form-data" method="post">')
        r.append('<input name="file" type="file" required />')
        r.append('<input type="submit" value="Upload" />')
        r.append('</form>')
        r.append('\n</body>\n</html>\n')
        encoded = '\n'.join(r).encode(enc, 'surrogateescape')
        f = io.BytesIO()
        f.write(encoded)
        f.seek(0)
        self.send_response(HTTPStatus.OK)
        self.send_header("Content-type", "text/html; charset=%s" % enc)
        self.send_header("Content-Length", str(len(encoded)))
        self.end_headers()
        return f

    def do_POST(self):
        content_type = self.headers.get('content-type')
        if not content_type or not content_type.startswith('multipart/form-data'):
            self.send_error(400, "Expected multipart/form-data")
            return

        boundary = content_type.split('boundary=')[-1].strip()
        content_length = int(self.headers.get('content-length', 0))
        body = self.rfile.read(content_length)

        parts = body.split(('--' + boundary).encode())
        for part in parts:
            if b'Content-Disposition' in part:
                headers_end = part.find(b'\r\n\r\n')
                if headers_end == -1:
                    continue

                header_section = part[:headers_end].decode('utf-8', errors='ignore')
                if 'filename=' in header_section:
                    filename_start = header_section.find('filename="') + 10
                    filename_end = header_section.find('"', filename_start)
                    filename = header_section[filename_start:filename_end]

                    if filename:
                        file_data = part[headers_end+4:].rstrip(b'\r\n')
                        filepath = os.path.join(os.getcwd(), os.path.basename(filename))

                        with open(filepath, 'wb') as f:
                            f.write(file_data)

                        self.send_response(200)
                        self.send_header('Content-type', 'text/html')
                        self.end_headers()
                        self.wfile.write(f'File uploaded: {filename}'.encode())
                        return

        self.send_error(400, "No file found in request")

HTTPRequestHandler.extensions_map['.cjs'] = 'application/x-javascript'

if __name__ == '__main__':
    http.server.test(HandlerClass=HTTPRequestHandler)
