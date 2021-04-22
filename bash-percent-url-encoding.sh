#!/bin/bash

function URL_DECODE(){
    local strArg
    for strArg in "$@"; do
        echo -e "${strArg//%/\\x}"
    done
}


function URL_ENCODE(){
    local length="${#1}"
    for ((i = 0; i < length; i++ )) ;do
        local c="${1:i:1}"
        case $c in 
            [a-zA-Z0-9.~_-])  printf "$c"  ;;
            *)  printf '%%%02X' "'$c"  ;;
        esac
    done
    printf '\n'
}
