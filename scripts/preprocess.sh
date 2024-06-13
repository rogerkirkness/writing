#!/bin/bash

output="pdf/combined.md"
echo "" > "$output"

# Holds tags
declare -A tags

# Collect posts and their tags
find _posts -name '*.md' | while IFS= read -r file; do
    if [ -f "$file" ]; then
        book_status=$(sed -n '/^book: false/p' "$file")
        if [ -z "$book_status" ]; then  # Proceed only if 'book: false' is not found
            tag=$(sed -n -e 's/^tags: \[\(.*\)\]/\1/p' "$file")
            tags[$tag]+="$file "  # Append file to the list of files for this tag
            echo "The post $file is in the $tag category"
        fi
    fi
done

echo "Tags found: ${!tags[@]}"

# Process each tag and its associated files
for tag in "${!tags[@]}"; do
    echo "Processing tag: $tag"
    echo -e "\n\n\\\\vspace*{0.30\\\\textheight}\n\\begin{center}\n# ${tag^}\n\\end{center}\n" >> "$output"
    for file in ${tags[$tag]}; do
        echo "Processing file: $file"
        title=$(sed -n '/^title: /p' "$file" | sed 's/title: //')
        echo -e "\n\n\\\\vspace*{0.30\\\\textheight}\n# $title\n\n" >> "$output"
        sed -e '1,/^\---$/d' -e '/^\---$/,$d' "$file" >> "$output"  # Strip YAML front matter
        echo -e "\n\n\\\\newpage\n\n" >> "$output"
    done
    echo -e "\n\n\\\\newpage\n\n" >> "$output"  # Add a page break after each tag section
done
