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

ENV LANG=en_US.UTF-8 LC_ALL=C
LABEL maintainer="Jeff Dickey <jdickey at seven-sigma dot com>"
LABEL description="Base image for ${RUBY_VERSION}alpine-${RUBY_EXTRA}, with NodeJS"
LABEL version="${VERSION}"
LABEL jdickey_ruby_image_version="${VERSION}"

# Install locales, which are not a default feature of Alpine Linux
RUN apk add --no-cache alpine-sdk bash build-base ca-certificates libressl-dev nodejs the_silver_searcher tzdata wget zsh && \
    wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub && \
    wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.30-r0/glibc-2.30-r0.apk && \
    wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.30-r0/glibc-bin-2.30-r0.apk && \
    wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.30-r0/glibc-i18n-2.30-r0.apk && \
    apk add glibc-2.30-r0.apk glibc-bin-2.30-r0.apk glibc-i18n-2.30-r0.apk

# Iterate through all locale and install it
# Note that locale -a is not available in alpine linux, use `/usr/glibc-compat/bin/locale -a` instead
COPY ./locale.md /locale.md
RUN cat locale.md | xargs -i /usr/glibc-compat/bin/localedef -i {} -f UTF-8 {}.UTF-8

# Set the language. This can also be specified as as environment variable in the docker-compose.yml file.
# According to several sources, "Using LC_ALL is strongly discouraged as it overrides everything. Please use it only when testing and never set it in a startup file."
ENV LANG=en_GB.UTF-8 \
    LANGUAGE=en_GB.UTF-8 \
    LC_ADDRESS="en_GB.UTF-8" \
    LC_COLLATE="en_GB.UTF-8" \
    LC_CTYPE="en_GB.UTF-8" \
    LC_IDENTIFICATION="en_GB.UTF-8" \
    LC_MEASUREMENT="en_GB.UTF-8" \
    LC_MESSAGES="en_GB.UTF-8" \
    LC_MONETARY="en_GB.UTF-8" \
    LC_NAME="en_GB.UTF-8" \
    LC_NUMERIC="en_GB.UTF-8" \
    LC_PAPER="en_GB.UTF-8" \
    LC_TELEPHONE="en_GB.UTF-8" \
    LC_TIME="en_GB.UTF-8" \
    LC_ALL=

RUN gem install yard && yard config --gem-install-yri \
    && gem install --no-document bundler && gem update --system && gem update && gem cleanup && \
    for i in `gem list | grep ', ' | grep -v default | cut -d ' ' -f 1`; do gem uninstall -i /usr/local/lib/ruby/gems/$RUBY_MAJOR.0 $i; done && \
    gem cleanup
