FROM ruby:2.5.0-alpine
ENV LANG en_US.UTF-8
ENV LC_ALL C
LABEL maintainer="Jeff Dickey <jdickey at seven-sigma dot com>"
LABEL description="Base image for Ruby 2.5.0 on Alpine Linux, with NodeJS, but without Qt"
LABEL includesQt=false
LABEL version="0.10.0"
RUN apk add --no-cache alpine-sdk \
                       bash \
                       build-base \
                       nodejs \
                       tzdata \
                       zsh
RUN gem install bundler && gem update && gem update --system && gem cleanup
