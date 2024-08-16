#!/bin/bash

function test_can_run_several_tests {
    : > ./about/testing/actual
    ./dist/test.sh ./about/testing/assertequals/several-tests >> ./about/testing/actual
    delta=`diff ./about/testing/actual ./about/testing/tests/expected-several-tests`

    assertequals "$delta" ""
}

function test_discloses_tests_count {
    : > ./about/testing/actual
    ./dist/test.sh ./about/testing/assertequals/several-tests >> ./about/testing/actual
    count=$(cat ./about/testing/actual | grep "test(s) run")

    assertequals "$count" "[0;102;30mPASS[0m - 2 test(s) run"
}

function test_can_report_failure {
    : > ./about/testing/actual
    echo "#!/bin/bash" > ./about/testing/assertequals/failure/failure.sh
    echo "function test_failure {" >> ./about/testing/assertequals/failure/failure.sh
    echo "    assertequals 1 2" >> ./about/testing/assertequals/failure/failure.sh
    echo "}" >> ./about/testing/assertequals/failure/failure.sh
    ./dist/test.sh ./about/testing/assertequals/failure >> ./about/testing/actual
    delta=`diff ./about/testing/actual ./about/testing/tests/expected-failure`
    rm ./about/testing/assertequals/failure/failure.sh
    
    assertequals "$delta" ""
}

function test_can_run_single_test {
    : > ./about/testing/actual
    echo "#!/bin/bash" > ./about/testing/assertequals/test-only/two.sh
    echo "function test_only_two {" >> ./about/testing/assertequals/test-only/two.sh
    echo "    assertequals 2 2" >> ./about/testing/assertequals/test-only/two.sh
    echo "}" >> ./about/testing/assertequals/test-only/two.sh
    ./dist/test.sh ./about/testing/assertequals/test-only >> ./about/testing/actual
    delta=`diff ./about/testing/actual ./about/testing/tests/expected-test-only`
    : > ./about/testing/assertequals/test-only/two.sh

    assertequals "$delta" ""
}
