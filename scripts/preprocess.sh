#!/bin/bash

output="pdf/combined.md"
echo "" > "$output"

find _posts -name '*.md' | sort | while IFS= read -r file; do
    if [ -f "$file" ]; then
        echo "Processing $file"
        title=$(sed -n '/^title: /p' "$file" | sed 's/title: //')
        echo -e "\n\n\\\\vspace*{0.30\\\\textheight}\n# $title\n\n" >> "$output"
        sed -e '1,/^\---$/d' -e '/^\---$/,$d' "$file" >> "$output"  # Strip YAML front matter
       # Add a new page unless it's the last file
        if [ $((i + 1)) -lt $total_files ]; then
            echo -e "\n\n\\\\newpage\n\n" >> "$output"
        fi
    else
        echo "Skipping missing file $file"
    fi
done
