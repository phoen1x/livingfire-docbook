#!/bin/bash
cd /book
mvn clean package
if [[ $? -ne 0 ]]; then
    echo -e "\e[31mbook creation failed\e[39m"
    exit 1
fi

# cleanup
chmod a+w /book -R
chmod a+w /plantuml -R
chmod a+w /wiki -R
chmod a+w /root/.m2 -R
exit 0
