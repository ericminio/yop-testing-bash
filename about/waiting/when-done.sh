#!/bin/bash

source './dist/waiting.sh'

function waiting_stops_when_done_wait_for_this {
    ls -l | grep "about" | wc -l
}

function test_waiting_stops_when_done {    
    result=$(waiting "about folder" waiting_stops_when_done_wait_for_this)

    assertequals "$result" "about folder is ready"
}

