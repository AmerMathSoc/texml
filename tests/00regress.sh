#!/bin/bash

texml="${0%%/*}/../bin/texml"

declare -i numtests=0
declare -i numfailed=0
declare -i numwarnings=0
declare -i numsucceeded=0
declare -i numskipped=0

if [ -z "$*" ]; then
    test_files="*.tex"
else
    test_files=$@
fi

for test_file in $test_files
do
    numtests=numtests+1

    test_name=${test_file%%.*}

    echo -n $test_name...

    if [ -e $test_name.xml.ref ]; then
        success=1

        if $texml $test_name.tex > /dev/null; then
            echo "texml succeeded"

            echo -n "    checking log file..."

            cmd='egrep \^\! $test_name.log | fgrep -v "Deleting empty paragraph"'

            if eval $cmd > /dev/null; then
                echo "errors found:"

                awk '/^!/ && ! /empty paragraph/ { print "       ", $0 } ' $test_name.log

                numwarnings=numwarnings+1
            else
                echo "clean!"
            fi

            echo -n "    checking XML output..."

            if diff -q $test_name.xml $test_name.xml.ref; then
                echo "clean!"
            else
                echo "FAILED (XML files differ)"
                success=0
            fi

            if [ -e $test_name.css.ref ]; then
                echo -n "    checking CSS output..."
                if diff -q $test_name.css $test_name.css.ref; then
                    echo "clean!"
                else
                    echo "FAILED (CSS files differ)"
                    success=0
                fi
            fi

            if (( success == 0 )); then
                numfailed=numfailed+1
            else
                numsucceeded=numsucceeded+1
            fi
        else
            echo "FAILED (could not reformat)"
            numfailed=numfailed+1
        fi
    else
        echo "skipping"
        numskipped=numskipped+1
    fi

    echo ""
done

echo "tests:      $numtests"
echo "successful: $numsucceeded"
echo "warnings:   $numwarnings"
echo "skipped:    $numskipped"
echo "failed:     $numfailed"

exit 0
