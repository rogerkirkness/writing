#!/bin/bash

output="pdf/combined.md"
echo "" > "$output"

for file in $(find _posts -name '*.md' | sort); do
    title=$(grep -Pzo '(?<=title: ).*' "$file" | tr -d '\0')  # Extract title assuming it's on a single line
    echo -e "\n\n# $title\n\n" >> "$output"  # Add the title as a level 1 Markdown header
    tail -n +2 "$file" | sed '/^---$/q' >> "$output"  # Skip front matter and add content to combined file
    echo -e "\n\n\newpage\n\n" >> "$output"  # Add LaTeX command for new page
done
