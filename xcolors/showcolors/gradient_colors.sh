#!/bin/bash

echo -e '\033[m'
for i in {0..7}; do
    for f in {0..7}; do
        echo -en "\033[$((f+30))m██▓▒░"
    done
    echo -e '\033[m'
done
echo -e '\033[m'
