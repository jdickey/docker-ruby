FROM jdickey/ruby:2.4.2-no-qt
LABEL maintainer="Jeff Dickey <jdickey at seven-sigma dot com>"
LABEL description="Base image for Ruby 2.4.2 on Debian Jessie, with PostgreSQL client and dev libraries, as well as NodeJS, and with Qt and capybara-webkit"
LABEL includesQt=true
LABEL version="0.9.0"
RUN apt-get update -qq && \
    apt-get install -y libqt4-webkit libqt4-dev xvfb && \
    apt-get clean && find /var/lib/apt/lists/* -delete
RUN gem install capybara-webkit && gem update && gem update --system && gem cleanup
