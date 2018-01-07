FROM ruby:2.5.0-alpine
ENV LANG en_US.UTF-8
ENV LC_ALL C
RUN apk add --no-cache bash zsh nodejs \
    alpine-sdk build-base qt5-qtwebkit-dev xvfb libxml2-dev libxslt-dev \
    postgresql-client postgresql-dev tzdata
RUN gem install bundler && gem update && gem update --system \
    && QMAKE=/usr/lib/qt5/bin/qmake gem install capybara-webkit \
    && gem cleanup
