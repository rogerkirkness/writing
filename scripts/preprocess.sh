#!/bin/bash

output="pdf/combined.md"
echo "" > "$output"

find _posts -name '*.md' | sort | while IFS= read -r file; do
    if [ -f "$file" ]; then
        echo "Processing $file"
        title=$(sed -n '/^title: /p' "$file" | sed 's/title: //')
        echo -e "\n\n\\vspace*{0.33\\textheight}\n# $title\n\n" >> "$output"
        sed -e '1,/^\---$/d' -e '/^\---$/,$d' "$file" >> "$output"  # Strip YAML front matter
        echo -e "\n\n\\\\newpage\n\n" >> "$output"
    else
        echo "Skipping missing file $file"
    fi
done
