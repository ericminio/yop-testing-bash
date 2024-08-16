#!/bin/bash

function test_assertmatch_pass {
    assertmatch "hello pretty world" "^hello.*world?"
}

