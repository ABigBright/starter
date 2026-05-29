#!/usr/bin/env bash
# Driver for interacting with this Neovim config via tmux.
# Usage:
#   ./driver.sh launch [file]    - start nvim in tmux session 'nvim'
#   ./driver.sh send <keys>      - send keys to nvim (tmux send-keys syntax)
#   ./driver.sh capture          - capture current pane content
#   ./driver.sh wait <pattern>   - poll until pattern appears in pane output
#   ./driver.sh quit             - send :qa to nvim, then kill tmux session
#   ./driver.sh headless <lua>   - run a lua snippet in headless nvim, print result
#   ./driver.sh checkhealth      - run :checkhealth headless
#   ./driver.sh lazy             - open Lazy UI, capture, then close
#   ./driver.sh neotree          - open Neo-tree, capture, then close
#   ./driver.sh telescope <cmd>  - open telescope with given command, capture, close

set -euo pipefail

SESSION="nvim"

TMUX_BIN="/usr/bin/tmux"
_detect_socket() {
  if [[ -n "${TMUX:-}" ]]; then
    local socket="${TMUX%%,*}"
    echo "$socket"
    return
  fi
  local uid="$(id -u)"
  local socket_dir="/tmp/tmux-${uid}"
  if [[ -d "$socket_dir" ]]; then
    local socket="$(ls "$socket_dir" | head -1)"
    if [[ -n "$socket" ]]; then
      echo "${socket_dir}/${socket}"
      return
    fi
  fi
  echo ""
}
TMUX_SOCKET="$(_detect_socket)"
T="$TMUX_BIN"
if [[ -n "$TMUX_SOCKET" ]]; then
  T="$TMUX_BIN -S $TMUX_SOCKET"
fi

launch() {
  local file="${1:-init.lua}"
  $T kill-session -t "$SESSION" 2>/dev/null || true
  $T new-session -d -s "$SESSION" -x 120 -y 40 "nvim $file"
  local basename="$(basename "$file")"
  local waited=0
  while [[ $waited -lt 100 ]]; do
    if $T capture-pane -t "$SESSION" -p | grep -q "$basename" 2>/dev/null; then
      break
    fi
    sleep 0.3
    waited=$((waited + 1))
  done
  # Let noice startup popups auto-dismiss (~5s), then send double-Escape
  # to dismiss any lingering popup (noice renders cmdline + messages as floats)
  sleep 5
  $T send-keys -t "$SESSION" Escape Escape
  sleep 1
  echo "nvim launched in tmux session '$SESSION' with file '$file'"
}

send() { $T send-keys -t "$SESSION" "$1"; }
capture() { $T capture-pane -t "$SESSION" -p; }

wait_for_pattern() {
  local pattern="$1"
  local timeout_secs="${2:-30}"
  local max_iters=$((timeout_secs * 3 + 1))
  local waited=0
  while [[ $waited -lt $max_iters ]]; do
    if $T capture-pane -t "$SESSION" -p | grep -q "$pattern" 2>/dev/null; then
      break
    fi
    sleep 0.3
    waited=$((waited + 1))
  done
  capture
}

quit() {
  $T send-keys -t "$SESSION" ":qa" Enter
  sleep 0.5
  $T kill-session -t "$SESSION" 2>/dev/null || true
  echo "nvim session terminated"
}

headless() { nvim --headless -c "lua $1" -c "q" 2>&1; }
checkhealth() { nvim --headless -c "checkhealth" -c "q" 2>&1; }

# Noice popups overlay everything -- every command triggers a cmdline popup
# and sometimes a messages popup. Send double-Escape before AND after each
# command to minimize interference with captures.

lazy() {
  send Escape
  send Escape
  sleep 1
  send ":Lazy"
  send Enter
  sleep 3
  send Escape
  send Escape
  sleep 2
  capture
  send "q"
  sleep 1
}

neotree() {
  send Escape
  send Escape
  sleep 1
  send ":Neotree"
  send Enter
  sleep 2
  send Escape
  send Escape
  sleep 1
  capture
  send ":Neotree close"
  send Enter
  sleep 1
}

telescope() {
  local cmd="${1:-find_files}"
  send Escape
  send Escape
  sleep 1
  send ":Telescope $cmd"
  send Enter
  sleep 3
  send Escape
  send Escape
  sleep 1
  capture
  send Escape
  sleep 1
}

case "${1:-help}" in
  launch)   launch "${2:-}" ;;
  send)     send "$2" ;;
  capture)  capture ;;
  wait)     wait_for_pattern "$2" "${3:-30}" ;;
  quit)     quit ;;
  headless) headless "$2" ;;
  checkhealth) checkhealth ;;
  lazy)     launch "${2:-init.lua}"; lazy; quit ;;
  neotree)  launch "${2:-init.lua}"; neotree; quit ;;
  telescope) launch "${2:-init.lua}"; telescope "${3:-find_files}"; quit ;;
  help)
    echo "Usage: $0 <command> [args]"
    echo "Commands: launch, send, capture, wait, quit, headless, checkhealth, lazy, neotree, telescope"
    ;;
  *)        echo "Unknown command: $1"; exit 1 ;;
esac