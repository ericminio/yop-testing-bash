#!/bin/bash

source './dist/waiting.sh'

function waiting_stops_after_10_tries_wait_for_this {
    ls -l | grep "u sure will not find this" | wc -l
}

function skip_waiting_stops_after_10_tries {    
    local result=$(waiting "random folder" waiting_stops_after_10_tries_wait_for_this)
    echo "$result"
    local stopped=$(echo "$result" | grep "Stopped after 10 seconds" | wc -l)

    assertequals "$stopped" 1
}

