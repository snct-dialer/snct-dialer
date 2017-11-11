#! /bin/bash

REL=`cat version`
SUMFILE="checksum/b2sum-${REL}.txt"
DIRS="LANG_www SuSE agi bin docs experimental extras libs sounds translations www"
FILES="changelog convert2pl.php FlyInclude.php genb2sums.sh GetGitRepro.sh INSTALL install.pl UPGRADE version"

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

