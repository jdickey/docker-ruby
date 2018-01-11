FROM jdickey/ruby:2.5.0-slim-no-qt
LABEL maintainer="Jeff Dickey <jdickey at seven-sigma dot com>"
LABEL description="Base image for Ruby 2.5.0 on slimmed-down Debian Stretch, with Qt and capybara-webkit"
LABEL includesQt=true
LABEL version="0.9.0"
RUN apt-get update -qq && \
    apt-get install -y libqtwebkit-dev xvfb && \
    apt-get clean && find /var/lib/apt/lists/* -delete
RUN gem install capybara-webkit && gem update && gem update --system && gem cleanup
