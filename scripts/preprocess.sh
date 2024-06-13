#!/bin/bash

output="pdf/combined.md"
echo "" > "$output"

find _posts -name '*.md' | sort | while IFS= read -r file; do
    if [ -f "$file" ]; then
        # Check if 'book' is set to 'false' in the front matter
        book_status=$(sed -n '/^book: false/p' "$file")
        if [ -z "$book_status" ]; then  # Only proceed if 'book: false' is not found
            echo "Processing $file"
            title=$(sed -n '/^title: /p' "$file" | sed 's/title: //')
            # Insert more code to handle tags if needed
            echo -e "\n\n\\\\vspace*{0.30\\\\textheight}\n# $title\n\n" >> "$output"
            sed -e '1,/^\---$/d' -e '/^\---$/,$d' "$file" >> "$output"  # Strip YAML front matter
            echo -e "\n\n\\\\newpage\n\n" >> "$output"
        else
            echo "Skipping $file (book set to false)"
        fi
    fi
done
