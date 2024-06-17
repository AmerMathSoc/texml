#!/bin/bash

if [ -z "$*" ]; then
    test_files="*.tex"
else
    test_files=$@
fi

for test_file in $test_files
do
    test_name=${test_file%.*}

    echo -n $test_name...

    if [ -e $test_name.xml ]; then
        git add $test_name.tex

        cp $test_name.xml $test_name.xml.ref

        git add $test_name.xml $test_name.xml.ref

        if [ -e $test_name.css ]; then
            cp $test_name.css $test_name.css.ref

            git add $test_name.css $test_name.css.ref
        fi
    else
        echo "skipping"
    fi

    echo ""
done

exit 0
