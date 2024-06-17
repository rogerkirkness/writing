#!/bin/bash

output="pdf/combined.md"
echo "" > "$output"

# Paths to images
honeycomb_image="images/honeycomb.png"
honeycombs_image="images/honeycombs.png"

# Process each tag and associated files
sortedTags=("Philosophy" "Reflection" "Technology" "Science" "Business" "Lifestyle" "Education" "Politics" "Futurism")
for i in "${!sortedTags[@]}"; do
    tag="${sortedTags[i]}"
    echo -e "\n\\\\addcontentsline{toc}{section}{$tag}\n" >> "$output"
    echo -e "\n\n\\\\vspace*{0.25\\\\textheight}\n\\\\begin{center}\n\\\\Huge $tag\n\\\\end{center}\n" >> "$output"
    echo -e "\n\\\\begin{center}\n\\\\includegraphics[width=0.2\\\\textwidth]{$honeycombs_image}\n\\\\end{center}\n" >> "$output"
    echo -e "\n\n\\\\newpage\n\n" >> "$output"

    while IFS= read -r file; do
        if [ -f "$file" ]; then
            book_status=$(sed -n '/^book: false/p' "$file")
            if [ -z "$book_status" ]; then  # Only proceed if 'book: false' is not found
                fileTag=$(sed -n -e 's/^tags: \[\(.*\)\]/\1/p' "$file")
                if [ $tag = $fileTag ]; then
                    echo $fileTag
                    title=$(sed -n '/^title: /p' "$file" | sed 's/title: //')
                    echo -e "\n\\\\addcontentsline{toc}{subsection}{$title}\n" >> "$output"
                    echo -e "\n\n\\\\vspace*{0.25\\\\textheight}\n\\\\begin{center}\n\\\\Large $title\n\\\\end{center}\n" >> "$output"
                    echo -e "\n\\\\begin{center}\n\\\\includegraphics[width=0.1\\\\textwidth]{$honeycomb_image}\n\\\\end{center}\n" >> "$output"
                    sed -e '1,/^\---$/d' -e '/^\---$/,$d' "$file" >> "$output"
                    echo -e "\n\n\\\\newpage\n\n" >> "$output"
                fi
            fi
        fi
    done < <(find _posts -name '*.md' | sort -r)
done