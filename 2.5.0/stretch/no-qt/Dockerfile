FROM ruby:2.5
ENV LANG en_US.UTF-8
ENV LC_ALL C
RUN apt-get update -qq && apt-get install -y build-essential \
    postgresql-client nodejs sudo zsh && \
    apt-get clean && rm -rf /var/lib/apt/lists/*
RUN gem install bundler && gem update && gem update --system
RUN gem cleanup
