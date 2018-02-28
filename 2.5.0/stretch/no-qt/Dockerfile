FROM ruby:2.5.0
ENV LANG en_US.UTF-8
ENV LC_ALL C
LABEL maintainer="Jeff Dickey <jdickey at seven-sigma dot com>"
LABEL description="Base image for Ruby 2.5.0 on Debian Stretch, with NodeJS, but without Qt"
LABEL includesQt=false
LABEL version="0.10.0"
RUN apt-get update -qq && \
    apt-get install -y build-essential nodejs sudo zsh && \
    apt-get clean && find /var/lib/apt/lists/* -delete
RUN gem install bundler && gem update && gem update --system && gem cleanup
