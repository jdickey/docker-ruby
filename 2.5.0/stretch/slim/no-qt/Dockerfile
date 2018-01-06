FROM ruby:2.5-slim
ENV LANG en_US.UTF-8
ENV LC_ALL C
RUN apt-get update -qq && apt-get install -y build-essential \
    libpq-dev postgresql-client \
    libxml2-dev libxslt1-dev \
    nodejs curl sudo wget zsh && \
    apt-get clean && rm -rf /var/lib/apt/lists/*
RUN gem install bundler && gem update && gem update --system
RUN gem cleanup
