# Bogus default value intended to force legit CLI argument use
ARG RUBY_VERSION=99.99.999
# e.g. --build-arg RUBY_EXTRA='3.7'
ARG RUBY_EXTRA=''
# e.g., '0.11.0'
ARG VERSION='NOT SET FROM CLI INVOCATION'

FROM ruby:${RUBY_VERSION}-alpine${RUBY_EXTRA}
ARG RUBY_VERSION
ARG RUBY_EXTRA
ARG VERSION

ENV LANG en_US.UTF-8
ENV LC_ALL C
LABEL maintainer="Jeff Dickey <jdickey at seven-sigma dot com>"
LABEL description="Base image for ${RUBY_VERSION}alpine-${RUBY_EXTRA}, with NodeJS"
LABEL version="${VERSION}"
LABEL jdickey_ruby_image_version="${VERSION}"

RUN apk add --no-cache alpine-sdk bash build-base libressl-dev nodejs tzdata zsh
RUN gem install yard && yard config --gem-install-yri \
    && gem install --no-document bundler && gem update --system && gem update && gem cleanup && \
    for i in `gem list | grep ', ' | grep -v default | cut -d ' ' -f 1`; do gem uninstall -i /usr/local/lib/ruby/gems/$RUBY_MAJOR.0 $i; done && \
    gem cleanup
