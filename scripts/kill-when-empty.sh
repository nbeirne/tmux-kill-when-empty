#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
. $CURRENT_DIR/helpers.sh

session_name="$(get_session_name)"

if all_commands_are_shells $session_name && any_clients_attached $session_name
then
  kill_session $session_name
fi

