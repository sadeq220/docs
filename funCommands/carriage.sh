#!/bin/bash

for i in {1..10};do
	printf "%-5s\r" ${i}
	sleep 1
done
