#!/bin/bash

output="pdf/combined.md"
echo "" > "$output"

# Declare an associative array to hold tag-post associations
declare -A tag_posts

# Collect posts into tags
find _posts -name '*.md' | while IFS= read -r file; do
    if [ -f "$file" ]; then
        # Extract tag from the front matter
        tag=$(sed -n -e 's/^tags: \[\(.*\)\]/\1/p' "$file")
        # Append file name to the tag array entry
        tag_posts["$tag"]+="$file "
    fi
done

# Process each tag and its associated posts
for tag in "${!tag_posts[@]}"; do
    # Create a title page for each tag
    echo -e "\n\n\\\\vspace*{0.30\\\\textheight}\n\\\\begin{center}\n# ${tag^}\n\\\\end{center}\n" >> "$output"
    echo -e "\n\n\\\\newpage\n\n" >> "$output"
    # Sort and iterate over each file associated with this tag
    for file in ${tag_posts[$tag]}; do
        echo "Processing $file under tag $tag"
        title=$(sed -n '/^title: /p' "$file" | sed 's/title: //')
        echo -e "\n\n\\\\vspace*{0.30\\\\textheight}\n# $title\n\n" >> "$output"
        sed -e '1,/^\---$/d' -e '/^\---$/,$d' "$file" >> "$output"  # Strip YAML front matter
        echo -e "\n\n\\\\newpage\n\n" >> "$output"
    done
done
