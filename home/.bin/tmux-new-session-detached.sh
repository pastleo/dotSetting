#!/bin/bash

source ~/.config/shrc/env
session_name="${1:-0}"
echo tmux new -d -s "$session_name"
tmux new -d -s "$session_name"
