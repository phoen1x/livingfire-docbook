#!/bin/bash
cd /wiki

# convert Markdown to Docbook
OUTPUT_DIR="/book/src/main/documentation/docbook/chapters"
find . \
    -name '*.md' \
    -exec pandoc --chapters -t docbook \
                 --output $OUTPUT_DIR/{}.xml {} ";"


cp /wiki/media/* /book/src/main/documentation/docbook/chapters/media
if [[ $? -ne 0 ]]; then
    echo -e "\e[31mimage copy failed\e[39m"
    exit 1
fi

# create book
/book/convertBook.sh
exit 0
