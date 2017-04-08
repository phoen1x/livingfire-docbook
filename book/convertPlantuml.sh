#!/bin/bash
cd /book

# DEBUG convert
#mvn exec:java -Dexec.mainClass="de.livingfire.Main" -Dexec.args="/wiki /wiki/media noop"

# convert
mvn exec:java -Dexec.mainClass="de.livingfire.Main" -Dexec.args="/wiki /wiki/media"

# convert .puml to .png
java -jar /plantuml/plantuml.jar /wiki/media/*.puml
if [[ $? -ne 0 ]]; then
    echo -e "\e[31mconversion failed\e[39m"
    exit 1
fi

# cleanup
chmod a+w /wiki -R
exit 0
