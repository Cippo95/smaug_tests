#!/bin/bash
#$1: stat to sum, $2: stats.txt
grep $1 $2 | awk '{ sum+=$2 } END {print sum}'
