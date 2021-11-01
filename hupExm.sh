#!/usr/bin/env bash
_file=${1:-temp}
touch ${_file}.txt
trap "echo 'hup checked' >>${_file}.txt" HUP #only if you terminate terminal by mouse
trap "echo 'term checked' >>${_file}.txt" TERM
trap "echo 'kill checked' >>${_file}.txt" KILL
trap "echo 'int checked' >>${_file}.txt" INT
sleep 20;

