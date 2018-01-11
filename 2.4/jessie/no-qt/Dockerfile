FROM ruby:2.4.2
ENV LANG en_US.UTF-8
ENV LC_ALL C
LABEL maintainer="Jeff Dickey <jdickey at seven-sigma dot com>"
LABEL description="Base image for Ruby 2.4.2 on Debian Jessie, with PostgreSQL client and dev libraries, as well as NodeJS, but without Qt"
LABEL includesQt=false
LABEL version="0.9.0"
RUN apt-get update -qq && \
    apt-get install -y build-essential \
                       curl \
                       libpq-dev \
                       libxml2-dev \
                       libxslt1-dev \
                       nodejs \
                       postgresql-client \
                       sudo \
                       wget \
                       zsh \
    && apt-get clean && find /var/lib/apt/lists/* -delete
RUN gem install bundler && gem update && gem update --system && gem cleanup
