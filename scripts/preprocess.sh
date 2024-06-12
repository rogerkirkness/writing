#!/bin/bash

echo "Current directory: $(pwd)"

image_path="images/honeycomb.jpeg"
output="pdf/combined.md"
echo "" > "$output"

find _posts -name '*.md' | sort | while IFS= read -r file; do
    if [ -f "$file" ]; then
        echo "Processing $file"
        title=$(sed -n '/^title: /p' "$file" | sed 's/title: //')
        echo -e "\n\n\\\\vspace*{0.30\\\\textheight}\n\\begin{center}\n# $title\n\n" >> "$output"
        echo -e "\\\\vspace*{0.07\\\\textheight}\n\\begin{center}\n\\\\includegraphics[width=0.8\\\\textwidth]{$image_path}\n\\\\end{center}\n" >> "$output"
        sed -e '1,/^\---$/d' -e '/^\---$/,$d' "$file" >> "$output"  # Strip YAML front matter
        echo -e "\n\n\\\\newpage\n\n" >> "$output"
    else
        echo "Skipping missing file $file"
    fi
done
