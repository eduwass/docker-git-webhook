#!/bin/bash
for file in /custom_scripts/before_pull/*; do
    "$file"
done