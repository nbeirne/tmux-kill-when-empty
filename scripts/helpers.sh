#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. $CURRENT_DIR/shells.sh

pane_format() { 
  echo "#{pane_current_command}" 
}

get_session_name() {
	tmux display -p "#{session_name}"
}

kill_session() {
  tmux kill-session -t "$1"
}

get_pane_commands() {
  tmux list-panes -s -F "$(pane_format)" -t "$1"
}

get_attached_clients() {
  tmux list-clients -t $1
}

# return 0 when cmd is a shell
check_cmd() {
  cmd="$1"
  for shell in $SHELLS
  do
    if [ "$cmd" == "$shell" ] 
    then
      return 0
    fi
  done
  return 1
}

# returns 0 when all commands are shells
all_commands_are_shells() {
  CMDS="$(get_pane_commands $1)"
  for cmd in $CMDS
  do
    if ! check_cmd $cmd
    then
      return 1
      # 1 is negative return value (ie, should NOT kill)
    fi
  done
  return 0
  # 0 is positive return value...
}

# returns 0 when any clients are attached
any_clients_attached() {
  clients="$(get_attached_clients $1)"
  if [ "$clients" == "" ]
  then
    return 0
  else 
    return 1
  fi
}
