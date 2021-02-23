#!/bin/bash
deURL(){
    local sArg;
    for sArg in "$@" ;do
        echo -e "${sArg//%/\\x}";
    done
}

enURL(){
    local len="${#1}"; local i=0
    for ((i = 0; i < len; i++ )) ;do
        local c="${1:i:1}";
        case $c in
            [a-zA-Z0-9.~_-]) printf "$c" ;;
            *) printf '%%%02X' "'$c" ;;
        esac
    done
    printf '\n'
}
