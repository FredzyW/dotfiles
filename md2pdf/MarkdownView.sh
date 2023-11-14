#!/bin/bash

input="$1"
output="${input%.*}.pdf"

zathura "$output" &
