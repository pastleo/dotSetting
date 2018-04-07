" PastLeo's vimrc
" ================================================

"--------------------------------------------------------------------------- 
" Some basic checkings and settings
"--------------------------------------------------------------------------- 
" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif
set nocompatible    " not compatible with the old-fashion vi mode

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
" Only do this part when compiled with support for autocommands.
" set t_Co=256
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
    au!

    " For all text files set 'textwidth' to 78 characters.
    autocmd FileType text setlocal textwidth=78

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).
    " Also don't do it when the mark is in the first line, that is the default
    " position when opening a file.
    autocmd BufReadPost *
          \ if line("'\"") > 1 && line("'\"") <= line("$") |
          \   exe "normal! g`\"" |
          \ endif

  augroup END
else
  set autoindent    " always set autoindenting on
  finish "require autocmd to continue
endif " has("autocmd")

"--------------------------------------------------------------------------- 
" Terminal and platform settings
"--------------------------------------------------------------------------- 
let s:bad_term=0

if has('win32')
  " set shell=powershell.exe\ -executionpolicy\ bypass
  if has('gui_running') " Using gvim
    let $LANG="en_US.UTF-8"
    set langmenu=en_US.utf-8
    set encoding=utf8
    set guifont=Consolas:h10

    set guioptions-=m  "remove menu bar
    set guioptions-=T  "remove toolbar
    set guioptions-=r  "remove right-hand scroll bar
    set guioptions-=L  "remove left-hand scroll bar
    set guioptions-=e  "use console tab instead of ugly gui tab

    set guicursor=n-v-c:block-Cursor
    set guicursor+=i:ver100-iCursor
    set guicursor+=n-v-c:blinkon0
    set guicursor+=i:blinkwait10


    " reload menu with UTF-8 encoding
    source $VIMRUNTIME/delmenu.vim
    source $VIMRUNTIME/menu.vim
  elseif !empty($CONEMUBUILD)
    if !empty($CONEMU_UTF8)
      set encoding=utf-8
      set termencoding=utf8
    endif
    if !empty($CONEMU_XTERM)
      set term=xterm
      set t_Co=256
      let &t_AB="\e[48;5;%dm"
      let &t_AF="\e[38;5;%dm"
    else
      let s:bad_term=1
    endif

    " Mouse scroll
    inoremap <Esc>[62~ <C-X><C-E>
    inoremap <Esc>[63~ <C-X><C-Y>
    nnoremap <Esc>[62~ <C-E>
    nnoremap <Esc>[63~ <C-Y>
  else
    let s:bad_term=1
  endif
endif

"--------------------------------------------------------------------------- 
" Encoding settings
"--------------------------------------------------------------------------- 
if has("multi_byte") && s:bad_term == 0
  if &termencoding == ""
    let &termencoding = &encoding
  endif
  set encoding=utf-8
  setglobal fileencoding=utf-8
  "setglobal bomb
  set fileencodings=ucs-bom,utf-8,big5,gb2312,latin1
endif

"--------------------------------------------------------------------------- 
" General settings
"--------------------------------------------------------------------------- 

" auto read when file is changed from outside
set autoread

" allow backspacing over everything in insert mode
set backspace=2
set backspace=indent,eol,start

set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

" keep 50 lines of command line history
set history=50

" show the cursor position all the time
set ruler

" do not keep a backup file, use versions instead
set nobackup

" display incomplete commands
set showcmd

" do incremental searching
set incsearch

" auto reload vimrc when editing it
autocmd! bufwritepost .vimrc source ~/.vimrc

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Dont save options to session file
set sessionoptions-=options

" Split at right and below
set splitright
set splitbelow

" stop from creating undo file
set noundofile

" smartcase
set smartcase

"--------------------------------------------------------------------------- 
" Functions and commands
"---------------------------------------------------------------------------

" Actions

function! s:get_visual_selection()
  " Why is this not a built-in Vim script function?!
  let [lnum1, col1] = getpos("'<")[1:2]
  let [lnum2, col2] = getpos("'>")[1:2]
  let lines = getline(lnum1, lnum2)
  let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
  let lines[0] = lines[0][col1 - 1:]
  return join(lines, "\n")
endfunction

fun! ReplaceOnNormalMode()
  let word = input("Replace A with B, A: ") 
  let replacement = input("Replace A with B, B: ") 
  exe '%sno/' . word . '/' . replacement . '/gc' 
endfun

fun! ReplaceOnVisualMode()
  let word = s:get_visual_selection()
  let replacement = input("Replace '" . word . "' with: ") 
  exe '%sno/' . word . '/' . replacement . '/gc' 
endfun

fun! EnterTasks()
  if s:plug_not_ready
    echom " [ plug(s) not ready ] :PlugS to sync"
  endif
  
  if exists(":NERDTree") &&
    \ (
      \ argc() == 0 && !exists("s:std_in") &&
      \ !filereadable(expand(g:session_directory . '/' . g:session_default_name . g:session_extension))
    \ )
    NERDTree
  endif
endfun

if !exists(":PlugS")
  fun! PlugS()
    if s:plug_not_ready == 1
      if executable('curl')
        !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
      else
        echo 'curl not found in this system'
      endif
      :source ~/.vimrc
    endif
    if s:plug_not_ready != 1
      PlugInstall --sync
      :source ~/.vimrc
    endif
  endfun
  command! PlugS call PlugS()
endif

" Processors

fun! Linend_DosToUnix()
  :update
  :e ++ff=dos
  :setlocal ff=unix
  :echo "use :w to save"
endfun
command! Linend2Unix call Linend_DosToUnix()

fun! Linend_UnixToDos()
  :update
  :e ++ff=dos
  :echo "use :w to save"
endfun
command! Linend2Dos call Linend_UnixToDos()

fun! ConvertIndentTabsToSpace()
  let new_tabstop = input("Convert tabs to spaces, how many spaces per tab?\n (press enter to use current tabstop = " . &tabstop . ") ")
  set expandtab
  if !empty(new_tabstop)
    exe 'set tabstop=' . new_tabstop
  endif
  retab
  echo "\n > Done. use :w to save"
endfun
command! ConvertIndent2Spaces call ConvertIndentTabsToSpace()

fun! ConvertIndentSpaceToTabs()
  set sts=&ts noet
  retab!
  echo "Convert space indent to spaces done. use :w to save"
endfun
command! ConvertIndent2Tabs call ConvertIndentSpaceToTabs()

"--------------------------------------------------------------------------- 
" Key mappings
"--------------------------------------------------------------------------- 
" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" Don't use Ex mode, use Q for formatting
map Q gq

" set leader to t key
let mapleader='t'
let g:mapleader='t'

" Block Visual
nnoremap <leader>v <C-v>

" Copy to system clipboard
if has("x11")
  vnoremap Y "+y 
else
  vnoremap Y "*y 
endif

nnoremap YY V"*y

" Search for selected text, forwards or backwards.
" From http://vim.wikia.com/wiki/Search_for_visually_selected_text
vnoremap <silent> / :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> ? :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>

" Replace
nnoremap <leader>r :call ReplaceOnNormalMode()<CR>
vnoremap <leader>r :call ReplaceOnVisualMode()<CR>

" Paste from system clipboard
nnoremap P "*p
nnoremap <leader>P P

" <leader>p toggles paste mode
nmap <leader>p :set paste!<BAR>set paste?<CR>

" allow multiple indentation/deindentation in visual mode
vnoremap < <gv
vnoremap > >gv

" fussy search and Open (edit) file
nnoremap <leader>o :e **/*

" New tab and split
nnoremap <leader>n :tabnew<CR>
nnoremap <leader>s :vnew<CR>
nnoremap <leader>i :new<CR>
nnoremap <leader>I :split<CR>
nnoremap <leader>S :vsplit<CR>

" Navigation before tabs
nnoremap <leader>h :tabprevious<CR>
nnoremap <leader>l :tabnext<CR>

" Navigation between splits
nnoremap <leader>j <C-W>w
nnoremap <leader>k <C-W>W

" Move split line
nnoremap <S-J> :resize +1<CR>
nnoremap <S-K> :resize -1<CR>
nnoremap <S-L> :vertical resize +2<CR>
nnoremap <S-H> :vertical resize -2<CR>

" Move tabs around
nnoremap <leader>. :tabmove +<CR>
nnoremap <leader>, :tabmove -<CR>

"--------------------------------------------------------------------------- 
" Autocmds
"--------------------------------------------------------------------------- 
" open a NERDTree automatically when vim starts up if no files were specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * call EnterTasks()

" file types
autocmd BufNewFile,BufRead *.jbuilder set filetype=ruby

"--------------------------------------------------------------------------- 
" Plugins : vim-plug
"--------------------------------------------------------------------------- 

if !filereadable(glob("~/.vim/autoload/plug.vim"))
  let s:plug_not_ready=1
  finish
endif

call plug#begin('~/.vim/plugged')

" Common packages
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-surround'
Plug 'ervandew/supertab'
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'xolox/vim-session'
Plug 'xolox/vim-misc'
Plug 'tpope/vim-sleuth'
Plug 'nathanaelkane/vim-indent-guides'

" Theme
Plug 'jnurmine/Zenburn'
Plug 'vim-airline/vim-airline-themes'

" Load only when being called
Plug 'mattn/emmet-vim', {'on': 'Emmet'}
Plug 'godlygeek/tabular', {'on': 'Tabularize'}

" Languages
Plug 'digitaltoad/vim-pug', {'for': 'pug'}
Plug 'slim-template/vim-slim', {'for': 'slim'}
Plug 'tpope/vim-rails', {'for': 'ruby'}
Plug 'tpope/vim-markdown', {'for': 'markdown'}
Plug 'pprovost/vim-ps1', {'for': 'ps1'}
Plug 'kchmck/vim-coffee-script', {'for': 'coffee'}
Plug 'posva/vim-vue', {'for': 'vue'}
Plug 'elixir-lang/vim-elixir'
Plug 'isobit/vim-caddyfile'
Plug 'pangloss/vim-javascript', {'for': ['js', 'mjs'] }

" Add plugins to &runtimepath
call plug#end()

if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  let s:plug_not_ready=2
  finish
else
  let s:plug_not_ready=0
endif

"--------------------------------------------------------------------------- 
" Plugin settings
"--------------------------------------------------------------------------- 

" NERDTree
let g:NERDTreeQuitOnOpen = 1

" Air-line
set laststatus=2 " Always show status line
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_theme='bubblegum'

" vim-gitgutter
let g:gitgutter_map_keys = 0
let g:gitgutter_enabled = 0

" vim-session
let g:session_directory = expand('~/.vim/sessions')
let g:session_default_name = substitute(substitute(getcwd(), '^/', '', ''), '\([^/]\)[^/]*/', '\1-', 'g')
let g:session_autosave = 'no'
let g:session_lock_enabled = 0

" vim-indent-guides
let g:indent_guides_enable_on_vim_startup = 1

"--------------------------------------------------------------------------- 
" Functions with plugins
"---------------------------------------------------------------------------

" Actions

fun! ToggleLineNumber()
  :GitGutterToggle
  set nu!
endfun

fun! SaveSessionAndQuit()
  if exists(":SaveSession")
    SaveSession
  endif
  :qa
endfun
:command! Q :call SaveSessionAndQuit()

"--------------------------------------------------------------------------- 
" Autocmds with plugins
"--------------------------------------------------------------------------- 
" leave vim if :q on last buffer
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

autocmd VimEnter * nunmap <leader>ig

" save session when leaving vim with more than one buffer
"autocmd VimLeavePre * AskToSaveSessionIfMoreThanOneBuffer() | endif
"autocmd VimLeavePre * call MySaveSessionOnQuit()

"--------------------------------------------------------------------------- 
" Key mappings with Plugins
"--------------------------------------------------------------------------- 

" Toggle line numbers
nnoremap <leader>N :call ToggleLineNumber()<CR>

" NERDTree
nnoremap <leader>t :NERDTreeFocus<CR>
nnoremap <leader>f :NERDTreeFind<CR>
nnoremap <leader>q :NERDTreeClose<CR>
let g:NERDTreeDirArrowExpandable = '>'
let g:NERDTreeDirArrowCollapsible = '+'

" NERDCommenter
vnoremap <leader>/ :call NERDComment(0, "toggle")<CR>
nnoremap <leader>/ :call NERDComment(0, "toggle")<CR>

" Emmet
nnoremap <leader>e :Emmet<space>

" Tabular
nnoremap <leader>= :Tabularize<space>/
vnoremap <leader>= :Tabularize<space>/

"--------------------------------------------------------------------------- 
" Theme
"--------------------------------------------------------------------------- 
if s:bad_term == 0
  set background=dark

  colorscheme zenburn

  " Overwrite some settings
  hi Normal ctermfg=NONE ctermbg=NONE guifg=#75f1ab guibg=#272822
  hi Cursor ctermfg=NONE ctermbg=NONE guifg=#272822 guibg=#e5e5e5
  hi iCursor ctermfg=NONE ctermbg=8 guifg=#272822 guibg=#717171
  hi Visual ctermfg=0 ctermbg=10 guifg=#272822 guibg=#4dff70

  hi TabLine      ctermfg=Black  ctermbg=242
  hi TabLineFill  ctermfg=Black  ctermbg=239
  hi TabLineSel   ctermfg=White  ctermbg=2

  let g:indent_guides_auto_colors = 0
  hi IndentGuidesEven guibg=#36382f ctermbg=235
endif

"--------------------------------------------------------------------------- 
" Keeping other unknown settings by generators
"--------------------------------------------------------------------------- 
" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
        \ | wincmd p | diffthis
endif

