#!/bin/bash
PORT='/dev/ttyUSB1'
PUSHCMD="ampy --port $PORT put "
CURDIR=$(pwd)
TOPDIR=${CURDIR%/*}

echo loading configs..
$PUSHCMD ~/secrets/wlanconfig.py

echo loading libraries...
$PUSHCMD micropython-max7219/max7219.py
$PUSHCMD $TOPDIR/micropythonexamples/common/wlan/wlan.py

echo loading main..
$PUSHCMD main.py


timeout 2  ampy --port $PORT run $TOPDIR/micropythonexamples/common/reset/reset.py

