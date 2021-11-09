#!/bin/bash

CPU=`lscpu | grep 'Model name' | cut -f 2 -d ":" | awk '{$1=$1}1'`

echo "Testing on $CPU"
echo ""
bold=$(tput bold)
normal=$(tput sgr0)

trim_ms () {
    trimmed="$( echo $1 | sed -r 's/([0-9]+\.[0-9]+)ms/\1/' )"
    
    echo "$trimmed"
}

for FOLDER in */; do
    FOLDER=`echo $FOLDER | sed 's/\///g'`
    echo "${bold}$FOLDER${normal}"
    declare -A tests
    
    if test -f "$FOLDER/c.c"; then
        # too lazy to combine these :)
        if [ ! -f "$FOLDER/c" ]; then
            gcc "$FOLDER/c.c" -O2 -fno-omit-frame-pointer -o "$FOLDER/c"
            chmod +x $FOLDER/c.c
        fi
    fi
    
    # todo should be iterated multiple times and averaged
    count=1
    for i in $(seq $count); do
        if test -f "$FOLDER/node.js"; then
            num=$(node "$FOLDER/node.js")
            num=$(trim_ms $num)
            tests[node]=$num
        fi
        
        if test -f "$FOLDER/ruby.rb"; then
            num=$(ruby "$FOLDER/ruby.rb")
            num=$(trim_ms $num)
            tests[ruby]=$num
        fi
        
        if test -f "$FOLDER/python.py"; then
            num=$(python3 "$FOLDER/python.py")
            num=$(trim_ms $num)
            tests[python]=$num
        fi
        
        if [ -d "$FOLDER/rust" ]; then
            cd "$FOLDER/rust"
            num=$(cargo run --release -q)
            num=$(trim_ms $num)
            tests[rust]=$num
            cd - > /dev/null
        fi
        
        if [ -d "$FOLDER/go" ]; then
            cd "$FOLDER/go"
            num=$(go run "./main.go")
            num=$(trim_ms $num)
            tests[go]=$num
            cd - > /dev/null
        fi
        
        if test -f "$FOLDER/c"; then
            c_time="$( TIMEFORMAT='%3R';time ( $FOLDER/c ) 2>&1 1>/dev/null )"
            c_time=`echo "scale=0; ($c_time * 1000)" | bc`
            c_time="${c_time}ms"
            num=`trim_ms $c_time`
            tests[c]=$num
        fi
    done
    
    pad=$(printf '%0.1s' " "{1..60})
    padlength=20
    
    for key in "${!tests[@]}"; do
        time="${tests[$key]}"
        printf '%s%*.*s%s\n' "$key:" 0 $((padlength - ${#key} - ${#time} )) "$pad" "$time"
        # echo "$key - ${tests[$key]}"
    done | sort -k3 -t ':' +1n -r
done
