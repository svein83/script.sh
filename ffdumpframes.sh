#!/bin/bash

# Function to dump every frame from a video into separate .png files using ffmpeg

function ffdumpframes(){
    for fN in "$@"; do
        if [ -f "${fN}" ] && [ -r "${fN}" ]; then
            fBN="$(basename "${fN}")"
            fPN="$(dirname "$(realpath "${fN}")")"
            mkdir -p "${fPN}"'/frames_'"${fBN}"
            ffmpeg -i "${fN}" "${fPN}"'/frames_'"${fBN}"'/'frame%04d.png
        else
            >&2 echo 'Invalid file: '"${fN}"
        fi
    done
}
