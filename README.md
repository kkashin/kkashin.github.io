# kkashin.github.io

My personal website, built using Jekyll.

The Jekyll config and site components are on the `jekyll` branch,
whereas the static site is on the `master` branch. This is because
the Jekyll site uses features that are not natively supported by Github's
automatic Jekyll builds.

To build:

```
git clone --single-branch --branch "jekyll" git@github.com:kkashin/kkashin.github.io.git
cd kkashin.github.io
./deploy.sh
```