#!/bin/bash


cd ../../www/vicidial
xgettext -d snctdialer -p locale -o snctdialer.pot --from-code=utf-8 *.php *.js

cd ../agc
xgettext -d snctdialer -p locale -o snctdialer.pot --from-code=utf-8 --keyword=_QXZ *.php *.js