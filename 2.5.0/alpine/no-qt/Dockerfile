FROM ruby:2.5.0-alpine
ENV LANG en_US.UTF-8
ENV LC_ALL C
RUN apk add --no-cache bash zsh nodejs tzdata postgresql-client \
        alpine-sdk build-base postgresql-dev \
    && rm -rf /var/cache/apk/*
RUN gem install bundler && gem update && gem update --system && gem cleanup
