# livingfire-docbook

Combine Markdown files (e.g. GitLab Wiki) in a [high quality PDF](https://gitlab.com/phoen1x/livingfire-docbook/raw/master/book.pdf)

## Usage

Make sure you have a working [Docker](https://docs.docker.com/engine/installation/) and
[docker-compose](https://docs.docker.com/compose/install/) environment.

```bash
# download
git clone https://phoen1x@gitlab.com/phoen1x/livingfire-docbook.git
cd livingfire-docbook

# start project
docker-compose up -d

# docbook to pdf
docker-compose exec docbook /book/convertBook.sh
xdg-open book/target/docbkx/pdf/book.pdf

# import GitLab wiki
cd tmp/wiki
git init
git remote add origin https://gitlab.com/phoen1x/livingfire-docbook.wiki.git
git pull
rm -rf .git
cd ../..

# markdown to docbook
docker-compose exec docbook /book/convertPlantuml.sh
docker-compose exec docbook /book/convertWiki2Docbook.sh
xdg-open book/target/docbkx/pdf/book.pdf

# stop project
docker-compose down
cat book/target/docbkx/pdf/book.pdf > book.pdf
```

See [project page](https://gitlab.com/phoen1x/livingfire-docbook/wikis/home) for more information.
