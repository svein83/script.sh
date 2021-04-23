#!/bin/bash

# Function for removing metadata tags from any audio/video file supported by ffmpeg

function ffuntag(){
    for fN in "$@"; do
        if [ -f "${fN}" ] && [ -r "${fN}" ]; then
            fBN="$(basename "${fN}")"
            fPN="$(dirname "$(realpath "${fN}")")"
            ffmpeg -hide_banner -i "${fN}" -map_metadata -1 -c:v copy -c:a copy "${fPN}"'/untagged_'"${fBN}"
        else
            >&2 echo 'Invalid file: '"${fN}"
        fi
    done
}
