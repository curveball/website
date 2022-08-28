JEKYLL_VERSION?=4.2.2

all: run

build: assets/css/style.css

assets/css/style.css: assets/css/style.scss _sass/*.scss
	sass assets/css/style.scss assets/css/style.css

sass-watch:
	sass --watch assets/css/style.scss:assets/css/style.css

run: build
	docker run --rm -p4000:4000 \
	  --volume="${PWD}:/srv/jekyll" \
	  -it jekyll/jekyll:${JEKYLL_VERSION} \
	  jekyll serve --watch --future
