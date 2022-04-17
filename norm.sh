#!/bin/bash

function normalize_path()
{
    # Remove all /./ sequences.
    local   path=${1//\/.\//\/}
    
    # Remove first dir/.. sequence.
    local   npath=$(echo $path | sed -e 's;[^/][^/]*/\.\./;;')
    
    # Remove remaining dir/.. sequence.
    while [[ $npath != $path ]]
    do
        path=$npath
        npath=$(echo $path | sed -e 's;[^/][^/]*/\.\./;;')
    done
    echo $path
}

if [[ $(basename $(basename $0 .sh) .old) == 'normalize_path' ]]; then
    if [[ "$*" ]]; then
        for p in "$@"
        do
            printf "%-30s => %s\n" $p $(normalize_path $p)
        done
    else
        for p in /test/../test/file test/../test/file .././test/../test/file
        do
            printf "%-30s => %s\n" $p $(normalize_path $p)
        done
    fi
fi
