#!/bin/bash
for file in /custom_scripts/on_startup/*; do
    "$file"
done