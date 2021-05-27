#!/usr/bin/env bash
_file=${1:-temp}
touch ${_file}.txt
trap "echo 'hup checked' >${_file}.txt" HUP
sleep 20;

