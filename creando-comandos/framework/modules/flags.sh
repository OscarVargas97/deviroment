#!/bin/bash

get_flags() {
  local iteration=1
  local flags=()
  for i in "$@"; do
    if [ $iteration -lt $comm_iterate ]; then
      flags+=($i)
    elif [ $iteration -ge $comm_iterate ]; then
      break
    fi
    iteration=$((iteration+1))
  done
  echo $flags
}
