#!/usr/bin/env bash
set -e # halt script on error

echo 'Jekyll build...'
bundle exec jekyll build

cp README.md _site/
cd _site

# add CNAME for custom domain name
echo "konstantinkashin.com" > CNAME

# deploy
git init
git add --all
git commit -m "Deploy to GitHub Pages"
git push --force "https://github.com/kkashin/kkashin.github.io" master:master
