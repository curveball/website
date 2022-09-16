ARG RUBY_VERSION=2.7.3
FROM ruby:$RUBY_VERSION

WORKDIR /opt/www

COPY Gemfile Gemfile
RUN gem update bundler
RUN bundle update
RUN bundle install

COPY . src

CMD bundle exec jekyll serve --watch --future --host 0.0.0.0 -s src/
