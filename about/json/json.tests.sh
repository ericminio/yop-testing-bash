#!/bin/bash

source './dist/utils.sh'

function test_json {
    local input=$' {  \n   "alive": true, \n  "value": 42 \n  }'
    local body=$(printf "%s" "$input" | json)    

    assertequals "$body" '{ "alive":true, "value":42 }'
}

function test_json_preserves_space_in_data {
    local input=$' { \n   "name": "Wonder  Woman" \n}'
    local body=$(printf "%s" "$input" | json)    

    assertequals "$body" '{ "name":"Wonder  Woman" }'
}

function test_json_gives_room_to_boundaries {
    local input=$'{"name":"Superman","planet":"Krypton"}'
    local body=$(printf "%s" "$input" | json)    

    assertequals "$body" '{ "name":"Superman", "planet":"Krypton" }'
}

