#!/bin/sh
set -e
BASEDIR=`dirname $0`

python  -c 'import greenify'
python $BASEDIR/slow_memcached_server.py > /dev/null &
pid=$!


if [[ `uname` == 'Linux' ]]; then
    echo
    echo "=== test gevent support ==="
    echo
    python $BASEDIR/gevent_issue.py
else
    echo
    echo "=== test gevent support (skip) ==="
    echo "    currently greenify only works on Linux"
fi


echo
echo "=== test GIL ==="
echo
python $BASEDIR/gil_issue.py
echo
echo "=== test timeout ==="
echo
python $BASEDIR/timeout_issue.py
kill $pid
