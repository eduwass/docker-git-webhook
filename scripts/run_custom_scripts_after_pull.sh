#!/bin/bash
for file in /custom_scripts/after_pull/*; do
    "$file"
done