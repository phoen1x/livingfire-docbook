# livingfire-docbook

Write your documents with Mardown in a [GitHub Page](https://pages.github.com/), [GitLab Wiki](https://about.gitlab.com/features/), [Golumn Wiki](https://github.com/gollum/gollum/wiki), ... and turn them with [DocBook](http://docbook.org/) into into a [high quality PDF](https://gitlab.com/phoen1x/livingfire-docbook/raw/master/book.pdf)

## Usage

See [project page](https://www.livingfire.de/docbook/)

## Quick Start

Make sure you have a working [Docker](https://docs.docker.com/engine/installation/) and
[docker-compose](https://docs.docker.com/compose/install/) environment.

```bash
# download project files
git clone https://gitlab.com/phoen1x/livingfire-docbook.git
cd livingfire-docbook

# start livingfire-docbook
docker-compose up -d

# convert docbook to pdf
docker-compose exec docbook /book/convertBook.sh
xdg-open book/target/docbkx/pdf/book.pdf

# write Markdown or import wiki
cd tmp/wiki
git init
git remote add origin https://gitlab.com/phoen1x/livingfire-docbook.wiki.git
git pull
rm -rf .git
cd ../..

# convert plantuml to images - http://plantuml.com/
docker-compose exec docbook /book/convertPlantuml.sh

# convert markdown to docbook
docker-compose exec docbook /book/convertWiki2Docbook.sh
xdg-open book/target/docbkx/pdf/book.pdf

# stop  livingfire-docbook and get PDF
docker-compose down
cat book/target/docbkx/pdf/book.pdf > book.pdf
```
