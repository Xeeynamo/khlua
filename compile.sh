#!/bin/sh
export LUAC="./luac5.1.exe -s"

function toUtf8 {
    # this function is only used once to convert the output from unlub from
    # UTF-16 to UTF-8, since LUAC can not understand UTF-16 code.
    for i in `ls`; do
        iconv -f UTF-16 -t UTF-8 $i > "CCC_$i"
    done
}

for file in `ls ./bbs_fm_commonlua/*.lua`; do
    $LUAC $file > "${file%.lua}.lub"
done

for file in `ls ./bbs_fm_lua/*.lua`; do
    $LUAC $file > "${file%.lua}.lub"
done
