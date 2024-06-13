#!/bin/bash

output="pdf/combined.md"
echo "" > "$output"

# Paths to images
honeycomb_image="images/honeycomb.png"
honeycombs_image="images/honeycombs.png"

# Arrays for tags and files
declare -a tagsArray
declare -a filesArray

# Function to add or append files to arrays
add_or_append() {
    local newtag="$1"
    local newfile="$2"
    for i in "${!tagsArray[@]}"; do
        if [[ "${tagsArray[i]}" == "$newtag" ]]; then
            filesArray[i]+="$newfile "
            return
        fi
    done
    tagsArray+=("$newtag")
    filesArray+=("$newfile ")
}

# Avoid using a subshell for the loop
while IFS= read -r file; do
    if [ -f "$file" ]; then
        book_status=$(sed -n '/^book: false/p' "$file")
        if [ -z "$book_status" ]; then  # Only proceed if 'book: false' is not found
            tag=$(sed -n -e 's/^tags: \[\(.*\)\]/\1/p' "$file")
            add_or_append "$tag" "$file"
        fi
    fi
done < <(find _posts -name '*.md' | sort)

# Process each tag and associated files
for i in "${!tagsArray[@]}"; do
    tag="${tagsArray[i]}"
    echo -e "\n\\\\addcontentsline{toc}{section}{$tag}\n" >> "$output"
    echo -e "\n\n\\\\vspace*{0.30\\\\textheight}\n\\\\begin{center}\n\\\\Huge $tag\n\\\\end{center}\n" >> "$output"
    echo -e "\n\\\\begin{center}\n\\\\includegraphics[width=0.2\\\\textwidth]{$honeycombs_image}\n\\\\end{center}\n" >> "$output"
    echo -e "\n\n\\\\newpage\n\n" >> "$output"
    files="${filesArray[i]}"
    for file in $files; do
        title=$(sed -n '/^title: /p' "$file" | sed 's/title: //')
        echo -e "\n\\\\addcontentsline{toc}{subsection}{$title}\n" >> "$output"
        echo -e "\n\n\\\\vspace*{0.30\\\\textheight}\n\\\\begin{center}\n\\\\Large $title\n\\\\end{center}\n" >> "$output"
        echo -e "\n\\\\begin{center}\n\\\\includegraphics[width=0.1\\\\textwidth]{$honeycomb_image}\n\\\\end{center}\n" >> "$output"
        sed -e '1,/^\---$/d' -e '/^\---$/,$d' "$file" >> "$output"
        echo -e "\n\n\\\\newpage\n\n" >> "$output"
    done
done