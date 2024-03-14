#!/bin/bash

_hob_ssh() {
  local cur prev ssh mock opts
  COMPREPLY=()
  cur="${COMP_WORDS[COMP_CWORD]}"
  prev="${COMP_WORDS[COMP_CWORD-1]}"
  mock="${MOCK:-u@mock.local}"
  ssh="${SSH_NC:-ssh}"
  opts=$(${ssh} "${mock}" hob_devices)
  COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
  return 0
}

complete -F _hob_ssh hob_ssh
