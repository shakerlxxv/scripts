#!/bin/bash

if [ $# -ne 1 ]; then
    echo "please enter final name"
    exit 1;
fi

FINAL=$1

cd $HOME

CMD="pdftk "

for F in out*.pnm; do
    echo "working $F ..."
    FOO=`echo $F | awk -F. '{print $1}'`
    pnmtops $F > $FOO.ps
    ps2pdf $FOO.ps 
    CMD="$CMD $FOO.pdf"
done

CMD="$CMD cat output $FINAL"

$CMD && rm -f out*.pnm out*.ps out*.pdf
