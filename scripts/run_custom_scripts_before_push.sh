#!/bin/bash
for file in /custom_scripts/before_push/*; do
    "$file"
done