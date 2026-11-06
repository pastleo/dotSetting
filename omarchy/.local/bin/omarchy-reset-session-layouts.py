#!/usr/bin/env python3
"""Start each Hyprland session floating; preserve changes until the next login."""

import os
from pathlib import Path
import re
import shutil


def main():
    session = os.environ.get("HYPRLAND_INSTANCE_SIGNATURE", "")
    runtime = os.environ.get("XDG_RUNTIME_DIR", "")
    if not session or not runtime or not re.fullmatch(r"[A-Za-z0-9_-]+", session):
        raise SystemExit("Cannot reset layouts without a Hyprland session and runtime directory")

    marker = Path(runtime) / "omarchy-session-layouts" / session
    if marker.exists():
        return

    state = Path(os.environ.get("XDG_STATE_HOME") or Path.home() / ".local/state") / "omarchy"
    layouts = state / "workspace-layouts"
    backup = state / "workspace-layout-backups" / session
    layouts.mkdir(parents=True, exist_ok=True)
    for source in layouts.iterdir():
        if re.fullmatch(r"[0-9]+\.lua", source.name) and source.is_file():
            backup.mkdir(parents=True, exist_ok=True)
            destination = backup / source.name
            if destination.exists():
                raise SystemExit(f"Refusing to overwrite layout backup: {destination}")
            shutil.move(str(source), str(destination))

    default = layouts / "default.lua"
    wanted = 'o.workspace_mode({ default = "floating" })\n'
    if default.exists() and default.read_text() != wanted:
        backup.mkdir(parents=True, exist_ok=True)
        shutil.copy2(default, backup / "default.lua")
    default.write_text(wanted)
    marker.parent.mkdir(parents=True, exist_ok=True)
    marker.touch()


if __name__ == "__main__":
    main()
