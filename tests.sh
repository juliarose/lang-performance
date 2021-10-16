#!/bin/bash

CPU=`lscpu | grep 'Model name' | cut -f 2 -d ":" | awk '{$1=$1}1'`

echo "Testing on $CPU"
echo ""
bold=$(tput bold)
normal=$(tput sgr0)

for FOLDER in */; do
    FOLDER=`echo $FOLDER | sed 's/\///g'`
    echo "${bold}$FOLDER${normal}"
    declare -A tests
    
    if test -f "$FOLDER/node.js"; then
        tests[node]=$(node "$FOLDER/node.js")
    fi
    
    if test -f "$FOLDER/ruby.rb"; then
        tests[ruby]=$(ruby "$FOLDER/ruby.rb")
    fi
    
    if test -f "$FOLDER/ruby.rb"; then
        tests[python]=$(python3 "$FOLDER/python.py")
    fi
    
    if [ -d "$FOLDER/rust" ]; then
        cd "$FOLDER/rust"
        tests[rust]=$(cargo run --release -q)
        cd - > /dev/null
    fi
    
    if [ -d "$FOLDER/go" ]; then
        cd "$FOLDER/go"
        tests[go]=$(go run "./main.go")
        cd - > /dev/null
    fi
    
    pad=$(printf '%0.1s' " "{1..60})
    padlength=20
    
    for key in "${!tests[@]}"; do
        time="${tests[$key]}"
        printf '%s%*.*s%s\n' "$key:" 0 $((padlength - ${#key} - ${#time} )) "$pad" "$time"
        # echo "$key - ${tests[$key]}"
    done | sort -k3 -t ':' +1n -r
done
