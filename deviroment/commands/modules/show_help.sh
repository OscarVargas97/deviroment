#!/bin/bash
ShowHelp(){
  initialize(){
    show_help "$1"
  }
  show_help(){
    (source "$1")
  }
  initialize "$@"
}