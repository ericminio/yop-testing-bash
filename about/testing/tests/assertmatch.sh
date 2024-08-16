#!/bin/bash

function test_assertmatch_can_report_success {
    : > ./about/testing/actual
    ./dist/test.sh ./about/testing/assertmatch/pass >> ./about/testing/actual
    delta=`diff ./about/testing/actual ./about/testing/assertmatch/pass/expected`

    assertequals "$delta" ""
}

function test_assertmatch_can_report_failure {
    : > ./about/testing/actual
    echo "#!/bin/bash" > ./about/testing/assertmatch/fail/one.sh
    echo "function test_assertmatch_fail {" >> ./about/testing/assertmatch/fail/one.sh
    echo "    assertmatch \"hello pretty world\" \"hello world\"" >> ./about/testing/assertmatch/fail/one.sh
    echo "}" >> ./about/testing/assertmatch/fail/one.sh
    ./dist/test.sh ./about/testing/assertmatch/fail >> ./about/testing/actual
    delta=`diff ./about/testing/actual ./about/testing/assertmatch/fail/expected`
    rm ./about/testing/assertmatch/fail/one.sh

    assertequals "$delta" ""
}
