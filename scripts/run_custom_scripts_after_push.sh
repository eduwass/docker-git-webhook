#!/bin/bash
for file in /custom_scripts/after_push/*; do
    "$file"
done