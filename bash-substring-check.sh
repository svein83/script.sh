#!/bin/bash

# Pass 2 args for valid check.
#   1. string to search inside
#   2. string to find 

function sting_in_string(){

    local HayStack="$1"
    local Needle="$2"
    
    if [[ "$HayStack" != *"${Needle}"* ]]; then
        echo \""$Needle"\"' is not in '\""$HayStack"\"'.'
    else
        echo \""$Needle"\"' is in '\""$HayStack"\"'.'
    fi
}
