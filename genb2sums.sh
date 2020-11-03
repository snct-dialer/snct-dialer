#! /bin/bash

REL=`cat version`
SUMFILE="checksum/b2sum-${REL}.txt"
DIRS="agi bin docs etc experimental extras libs license sounds tools translations www"
FILES="changelog SNCTVersion.inc genb2sums.sh GetGitRepro.sh INSTALL install.pl UPGRADE version readme.md"

rm -f ${SUMFILE}

SEND="NO"


for PP in ${DIRS}
do

    for f in $(find ${PP} -name '*'); do b2sum $f >>${SUMFILE} ; done

done


for PP in ${FILES}
do

    for f in $(find ${PP} -name '*'); do b2sum $f >>${SUMFILE} ; done

done

