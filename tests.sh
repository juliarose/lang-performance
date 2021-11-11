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
    
    # todo should be iterated multiple times and averaged
    count=5
    
    declare -A tests
    
    if test -f "$FOLDER/c.c"; then
        # too lazy to combine these :)
        if [ ! -f "$FOLDER/c" ]; then
            gcc "$FOLDER/c.c" -O2 -fno-omit-frame-pointer -o "$FOLDER/c"
            chmod +x $FOLDER/c.c
        fi
    fi
    
    if test -f "$FOLDER/java.java"; then
        if [ ! -f "$FOLDER/Java.class" ]; then
            javac "$FOLDER/java.java"
        fi
    fi
    
    for i in $(seq $count); do
        if test -f "$FOLDER/node.js"; then
            num=$(node "$FOLDER/node.js")
            num=$(trim_ms $num)
            
            if [[ -v tests[node] ]]; then
                prev="${tests[node]}"
                tests[node]=`echo "$prev + $num" | bc`
            else
                tests[node]=$num
            fi
        fi
        
        if test -f "$FOLDER/java.java"; then
            cd "$FOLDER/"
            num=$(java Java)
            num=$(trim_ms $num)
            cd - > /dev/null
            
            if [[ -v tests[java] ]]; then
                prev="${tests[java]}"
                tests[java]=`echo "$prev + $num" | bc`
            else
                tests[java]=$num
            fi
        fi
        
        if test -f "$FOLDER/ruby.rb"; then
            num=$(ruby "$FOLDER/ruby.rb")
            num=$(trim_ms $num)
            
            if [[ -v tests[ruby] ]]; then
                prev="${tests[ruby]}"
                tests[ruby]=`echo "$prev + $num" | bc`
            else
                tests[ruby]=$num
            fi
        fi
        
        if test -f "$FOLDER/python.py"; then
            num=$(python3 "$FOLDER/python.py")
            num=$(trim_ms $num)
            
            if [[ -v tests[python] ]]; then
                prev="${tests[python]}"
                tests[python]=`echo "$prev + $num" | bc`
            else
                tests[python]=$num
            fi
        fi
        
        if [ -d "$FOLDER/rust" ]; then
            cd "$FOLDER/rust"
            num=$(cargo run --release -q)
            num=$(trim_ms $num)
            cd - > /dev/null
            
            if [[ -v tests[rust] ]]; then
                prev="${tests[rust]}"
                tests[rust]=`echo "$prev + $num" | bc`
            else
                tests[rust]=$num
            fi
        fi
        
        if [ -d "$FOLDER/go" ]; then
            cd "$FOLDER/go"
            num=$(go run "./main.go")
            num=$(trim_ms $num)
            cd - > /dev/null
            
            if [[ -v tests[go] ]]; then
                prev="${tests[go]}"
                tests[go]=`echo "$prev + $num" | bc`
            else
                tests[go]=$num
            fi
        fi
        
        if test -f "$FOLDER/julia.jl"; then
            num=$(julia "$FOLDER/julia.jl")
            num=$(trim_ms $num)
            
            if [[ -v tests[julia] ]]; then
                prev="${tests[julia]}"
                tests[julia]=`echo "$prev + $num" | bc`
            else
                tests[julia]=$num
            fi
        fi
        
        if test -f "$FOLDER/c"; then
            c_time="$( TIMEFORMAT='%3R'; time ( $FOLDER/c ) 2>&1 1>/dev/null )"
            c_time=`echo "scale=0; ($c_time * 1000)" | bc`
            c_time="${c_time}ms"
            num=`trim_ms $c_time`
            
            if [[ -v tests[c] ]]; then
                prev="${tests[c]}"
                tests[c]=`echo "$prev + $num" | bc`
            else
                tests[c]=$num
            fi
        fi
    done
    
    pad=$(printf '%0.1s' " "{1..60})
    padlength=20
    
    for key in "${!tests[@]}"; do
        time=`echo "scale=2; ${tests[$key]} / $count" | bc`
        printf '%s%*.*s%s\n' "$key:" 0 $((padlength - ${#key} - ${#time} )) "$pad" "$time"
        # echo "$key - ${tests[$key]}"
    done | sort -k3 -t ':' +1n -r
done
