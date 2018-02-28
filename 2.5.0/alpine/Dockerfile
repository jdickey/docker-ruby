FROM jdickey/ruby:2.5.0-alpine-no-qt
LABEL maintainer="Jeff Dickey <jdickey at seven-sigma dot com>"
LABEL description="Base image for Ruby 2.5.0 on Alpine Linux, with NodeJS, Qt and capybara-webkit"
LABEL includesQt=true
LABEL version="0.10.0"
RUN apk add --no-cache libxml2-dev \
                       libxslt-dev \
                       qt5-qtwebkit-dev \
                       xvfb
RUN gem update && gem update --system && \
    QMAKE=/usr/lib/qt5/bin/qmake gem install capybara-webkit && \
    gem cleanup
