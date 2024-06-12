#!/bin/bash

output_dir="pdf"
output_file="${output_dir}/combined.md"
honeycomb_image_path="/images/honeycomb.jpeg"  # Update this path

# Ensure the output directory exists
mkdir -p "$output_dir"
echo "" > "$output_file"

find _posts -name '*.md' | sort | while IFS= read -r file; do
    if [ -f "$file" ]; then
        echo "Processing $file"
        # Extract title ensuring to remove front matter properly
        title=$(sed -n '/^title: /p' "$file" | sed 's/title: //')
        # Use LaTeX to position the title and include the honeycomb design
        echo -e "\n\n\\vspace*{\\fill}\n# $title\n" >> "$output_file"
        # echo -e "\n\\begin{center}\n\\includegraphics[width=\\textwidth]{$honeycomb_image_path}\n\\end{center}\n" >> "$output_file"
        echo -e "\\vspace*{\\fill}\n\\newpage\n\n" >> "$output_file"
        # Append the content of the file, skipping the YAML front matter
        sed -n '/^---$/,/^---$/!p' "$file" >> "$output_file"
    else
        echo "Skipping missing file $file"
    fi
done
