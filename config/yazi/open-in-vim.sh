#!/bin/sh
# Open file(s) in an existing vim/nvim pane in the current tmux window.
# Falls back to plain vim if no such pane exists.

pane=$(tmux list-panes -F '#{pane_id} #{pane_current_command}' 2>/dev/null \
  | awk '$2 == "vim" || $2 == "nvim" {print $1; exit}')

if [ -z "$pane" ]; then
  exec vim "$@"
fi

for f in "$@"; do
  case "$f" in
    /*) abs=$f ;;
    *)  abs=$PWD/$f ;;
  esac
  # Escape characters vim treats specially on the command line
  esc=$(printf '%s' "$abs" | sed 's/[\\ %#|]/\\&/g')
  tmux send-keys -t "$pane" Escape
  tmux send-keys -t "$pane" -l ":edit $esc"
  tmux send-keys -t "$pane" Enter
done

tmux select-pane -t "$pane"
