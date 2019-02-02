# Bogus default value intended to force legit CLI argument use
ARG RUBY_VERSION=99.99.999
# e.g. --build-arg RUBY_EXTRA='-slim-jessie'
ARG RUBY_EXTRA=''
# e.g., '0.11.0'
ARG VERSION='NOT SET FROM CLI INVOCATION'

FROM ruby:${RUBY_VERSION}${RUBY_EXTRA}
ARG RUBY_VERSION
ARG RUBY_EXTRA
ARG VERSION

ENV LANG en_US.UTF-8
ENV LC_ALL C
LABEL maintainer="Jeff Dickey <jdickey at seven-sigma dot com>"
LABEL description="Base image for ${RUBY_VERSION}${RUBY_EXTRA}, with NodeJS, but without Qt"
LABEL includesQt=false
LABEL version="${VERSION}"
LABEL jdickey_ruby_no-qt_image_version="${VERSION}"

RUN apt-get update -qq && apt-get dist-upgrade -y && \
    apt-get install -y build-essential curl less nodejs sudo wget zsh \
    && apt-get clean && find /var/lib/apt/lists/* -delete
RUN gem install yard && yard config --gem-install-yri \
    && gem install bundler && gem update --system && gem update && gem cleanup && \
    for i in `gem list | grep ', ' | grep -v default | cut -d ' ' -f 1`; do gem uninstall -i /usr/local/lib/ruby/gems/$RUBY_MAJOR.0 $i; done && \
    gem cleanup
