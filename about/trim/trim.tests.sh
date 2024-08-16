#!/bin/bash

source './dist/utils.sh'

function test_trim_can_remove_leading_spaces {
    local input=$'   123'
    local actual=$(printf "%s" "$input" | trim)    

    assertequals "$actual" "123"
}

function test_trim_can_remove_trailing_spaces {
    local input=$'123   '
    local actual=$(printf "%s" "$input" | trim)    

    assertequals "$actual" "123"
}

function test_trim_preserves_inner_spaces {
    local input=$' 1 2 3 '
    local actual=$(printf "%s" "$input" | trim)

    assertequals "$actual" "1 2 3"
}

function test_trim_needs_help_to_remove_trailing_cr_lf {
    local input=$'123  \r\n\n  '    
    local actual=$(printf "%s" "$input" | oneliner | trim)    
    
    assertequals "$actual" "123"
}

function test_trim_needs_help_to_remove_leading_cr_lf {
    local input=$'  \r\n\n  123'
    local actual=$(printf "%s" "$input" | oneliner | trim)
    
    assertequals "$actual" "123"
}

function test_trim_digests_grep_one_line {
    echo "hello " > ./about/incoming
    echo "world" >> ./about/incoming
    local actual=$(cat ./about/incoming | grep "hello" | trim)

    assertequals "$actual" "hello"
}

function test_trim_digests_grep_two_lines_with_help {
    echo "  hello world     " > ./about/incoming
    echo "hello my friend  " >> ./about/incoming
    echo "bye for now      " >> ./about/incoming
    local actual=$(cat ./about/incoming | grep "hello" | oneliner | shrink | trim)    

    assertequals "$actual" "hello world hello my friend"
}


