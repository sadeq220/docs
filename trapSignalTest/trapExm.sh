#!/usr/bin/env bash
_file=${1:-temp}
touch ${_file}.txt
trap "rm -f ${_file}.txt" EXIT
read -p "enter some text:" string
echo $string>${_file}.txt;
sleep 20;

