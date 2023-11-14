# Check if a file is provided as an argument
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <path_to_markdown_file>"
    exit 1
fi

# Convert markdown to PDF
pandoc "$1" -o "${1%.md}.pdf"

