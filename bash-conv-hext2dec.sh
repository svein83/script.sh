#!/bin/bash

function hex_to_dec(){ 
local strA
  for strA in "$@"; do
      printf '%u\n' '0x'"$strA";
  done
}
