FROM ruby:2.5.0
ENV LANG en_US.UTF-8
ENV LC_ALL C
LABEL maintainer="Jeff Dickey <jdickey at seven-sigma dot com>"
LABEL description="Base image for Ruby 2.5.0 on Debian Stretch, with PostgreSQL client and dev libraries, as well as NodeJS, but without Qt"
LABEL includesQt=false
LABEL version="0.9.0"
RUN apt-get update -qq && apt-get install -y build-essential \
    postgresql-client nodejs sudo zsh && \
   apt-get clean && find /var/lib/apt/lists/* -delete
RUN gem install bundler && gem update && gem update --system && gem cleanup
