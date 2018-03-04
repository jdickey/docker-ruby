#!/bin/bash

###
### 2.5.0 on Debian Stretch
###

docker build --build-arg RUBY_VERSION=2.5.0 \
             --build-arg RUBY_EXTRA='-stretch' \
             --build-arg VERSION=0.11.0 \
             --tag 'jdickey/ruby:2.5.0-stretch-no-qt' \
             --squash --file Dockerfile.no-qt.debian .

docker build --build-arg RUBY_VERSION=2.5.0 \
             --build-arg RUBY_EXTRA='-stretch' \
             --build-arg QTLIBS="libqtwebkit-dev qt5-qmake" \
             --build-arg VERSION=0.11.0 \
             --tag 'jdickey/ruby:2.5.0-stretch' \
             --squash --file Dockerfile.main.debian .

docker build --build-arg RUBY_VERSION=2.5.0 \
             --build-arg RUBY_EXTRA='-slim-stretch' \
             --build-arg VERSION=0.11.0 \
             --tag 'jdickey/ruby:2.5.0-slim-stretch-no-qt' \
             --squash --file Dockerfile.no-qt.debian .

docker build --build-arg RUBY_VERSION=2.5.0 \
             --build-arg RUBY_EXTRA='-slim-stretch' \
             --build-arg QTLIBS="libqtwebkit-dev qt5-qmake" \
             --build-arg VERSION=0.11.0 \
             --tag 'jdickey/ruby:2.5.0-slim-stretch' \
             --squash --file Dockerfile.main.debian .

docker tag jdickey/ruby:2.5.0-stretch jdickey/ruby:2.5.0
docker tag jdickey/ruby:2.5.0 jdickey/ruby:latest
docker tag jdickey/ruby:2.5.0 jdickey/ruby:2
docker tag jdickey/ruby:2.5.0 jdickey/ruby:2.5
docker tag jdickey/ruby:2.5.0 jdickey/ruby:stretch
docker tag jdickey/ruby:2.5.0 jdickey/ruby:2-stretch
docker tag jdickey/ruby:2.5.0 jdickey/ruby:2.5-stretch

docker tag jdickey/ruby:2.5.0-stretch-no-qt jdickey/ruby:2.5.0-no-qt
docker tag jdickey/ruby:2.5.0-no-qt jdickey/ruby:2-no-qt
docker tag jdickey/ruby:2.5.0-no-qt jdickey/ruby:2.5-no-qt
docker tag jdickey/ruby:2.5.0-no-qt jdickey/ruby:2-stretch-no-qt
docker tag jdickey/ruby:2.5.0-no-qt jdickey/ruby:2.5-stretch-no-qt
docker tag jdickey/ruby:2.5.0-no-qt jdickey/ruby:stretch-no-qt

docker tag jdickey/ruby:2.5.0-slim-stretch-no-qt jdickey/ruby:2.5.0-slim-no-qt
docker tag jdickey/ruby:2.5.0-slim-no-qt jdickey/ruby:slim-no-qt
docker tag jdickey/ruby:2.5.0-slim-no-qt jdickey/ruby:2-slim-no-qt
docker tag jdickey/ruby:2.5.0-slim-no-qt jdickey/ruby:2.5-slim-no-qt
docker tag jdickey/ruby:2.5.0-slim-no-qt jdickey/ruby:2-slim-stretch-no-qt
docker tag jdickey/ruby:2.5.0-slim-no-qt jdickey/ruby:2.5-slim-stretch-no-qt
docker tag jdickey/ruby:2.5.0-slim-no-qt jdickey/ruby:slim-stretch-no-qt

docker tag jdickey/ruby:2.5.0-slim-stretch jdickey/ruby:2.5.0-slim
docker tag jdickey/ruby:2.5.0-slim jdickey/ruby:slim
docker tag jdickey/ruby:2.5.0-slim jdickey/ruby:2-slim
docker tag jdickey/ruby:2.5.0-slim jdickey/ruby:2.5-slim
docker tag jdickey/ruby:2.5.0-slim jdickey/ruby:2-slim-stretch
docker tag jdickey/ruby:2.5.0-slim jdickey/ruby:2.5-slim-stretch
docker tag jdickey/ruby:2.5.0-slim jdickey/ruby:slim-stretch

###
### 2.5.0 on Alpine 3.7
###

docker build --build-arg RUBY_VERSION=2.5.0 \
             --build-arg RUBY_EXTRA='3.7' \
             --build-arg VERSION=0.11.0 \
             --tag 'jdickey/ruby:2.5.0-alpine3.7-no-qt' \
             --squash --file Dockerfile.no-qt.alpine .

docker build --build-arg RUBY_VERSION=2.5.0 \
             --build-arg RUBY_EXTRA='3.7' \
             --build-arg VERSION=0.11.0 \
             --build-arg QTLIBS=qt5-qtwebkit-dev \
             --tag 'jdickey/ruby:2.5.0-alpine3.7' \
             --squash --file Dockerfile.main.alpine .

docker tag jdickey/ruby:2.5.0-alpine3.7-no-qt jdickey/ruby:2.5.0-alpine-no-qt
docker tag jdickey/ruby:2.5.0-alpine-no-qt jdickey/ruby:2.5-alpine-no-qt
docker tag jdickey/ruby:2.5.0-alpine-no-qt jdickey/ruby:2-alpine-no-qt
docker tag jdickey/ruby:2.5.0-alpine-no-qt jdickey/ruby:alpine-no-qt

docker tag jdickey/ruby:2.5.0-alpine3.7 jdickey/ruby:2.5.0-alpine
docker tag jdickey/ruby:2.5.0-alpine jdickey/ruby:2.5-alpine
docker tag jdickey/ruby:2.5.0-alpine jdickey/ruby:2-alpine
docker tag jdickey/ruby:2.5.0-alpine jdickey/ruby:alpine

###
### 2.4.3 on Debian Jessie
###

docker build --build-arg RUBY_VERSION=2.4.3 \
             --build-arg RUBY_EXTRA='-jessie' \
             --build-arg VERSION=0.11.0 \
             --tag 'jdickey/ruby:2.4.3-jessie-no-qt' \
             --squash --file Dockerfile.no-qt.debian .

docker build --build-arg RUBY_VERSION=2.4.3 \
             --build-arg RUBY_EXTRA='-jessie' \
             --build-arg QTLIBS="libqt4-webkit libqt4-dev qt4-qmake" \
             --build-arg VERSION=0.11.0 \
             --tag 'jdickey/ruby:2.4.3-jessie' \
             --squash --file Dockerfile.main.debian .

docker build --build-arg RUBY_VERSION=2.4.3 \
             --build-arg RUBY_EXTRA='-slim-jessie' \
             --build-arg VERSION=0.11.0 \
             --tag 'jdickey/ruby:2.4.3-slim-jessie-no-qt' \
             --squash --file Dockerfile.no-qt.debian .

docker build --build-arg RUBY_VERSION=2.4.3 \
             --build-arg RUBY_EXTRA='-slim-jessie' \
             --build-arg QTLIBS="libqt4-webkit libqt4-dev qt4-qmake" \
             --build-arg VERSION=0.11.0 \
             --tag 'jdickey/ruby:2.4.3-jessie-slim' \
             --squash --file Dockerfile.main.debian .

docker tag jdickey/ruby:2.4.3-jessie jdickey/ruby:2.4.3
docker tag jdickey/ruby:2.4.3 jdickey/ruby:latest
docker tag jdickey/ruby:2.4.3 jdickey/ruby:2
docker tag jdickey/ruby:2.4.3 jdickey/ruby:2.5
docker tag jdickey/ruby:2.4.3 jdickey/ruby:jessie
docker tag jdickey/ruby:2.4.3 jdickey/ruby:2-jessie
docker tag jdickey/ruby:2.4.3 jdickey/ruby:2.5-jessie

docker tag jdickey/ruby:2.4.3-jessie-no-qt jdickey/ruby:2.4.3-no-qt
docker tag jdickey/ruby:2.4.3-no-qt jdickey/ruby:2-no-qt
docker tag jdickey/ruby:2.4.3-no-qt jdickey/ruby:2.5-no-qt
docker tag jdickey/ruby:2.4.3-no-qt jdickey/ruby:2-jessie-no-qt
docker tag jdickey/ruby:2.4.3-no-qt jdickey/ruby:2.5-jessie-no-qt
docker tag jdickey/ruby:2.4.3-no-qt jdickey/ruby:jessie-no-qt

docker tag jdickey/ruby:2.4.3-slim-jessie-no-qt jdickey/ruby:2.4.3-slim-no-qt
docker tag jdickey/ruby:2.4.3-slim-no-qt jdickey/ruby:slim-no-qt
docker tag jdickey/ruby:2.4.3-slim-no-qt jdickey/ruby:2-slim-no-qt
docker tag jdickey/ruby:2.4.3-slim-no-qt jdickey/ruby:2.5-slim-no-qt
docker tag jdickey/ruby:2.4.3-slim-no-qt jdickey/ruby:2-slim-jessie-no-qt
docker tag jdickey/ruby:2.4.3-slim-no-qt jdickey/ruby:2.5-slim-jessie-no-qt
docker tag jdickey/ruby:2.4.3-slim-no-qt jdickey/ruby:slim-jessie-no-qt

docker tag jdickey/ruby:2.4.3-slim-jessie jdickey/ruby:2.4.3-slim
docker tag jdickey/ruby:2.4.3-slim jdickey/ruby:slim
docker tag jdickey/ruby:2.4.3-slim jdickey/ruby:2-slim
docker tag jdickey/ruby:2.4.3-slim jdickey/ruby:2.5-slim
docker tag jdickey/ruby:2.4.3-slim jdickey/ruby:2-slim-jessie
docker tag jdickey/ruby:2.4.3-slim jdickey/ruby:2.5-slim-jessie
docker tag jdickey/ruby:2.4.3-slim jdickey/ruby:slim-jessie

###
### 2.4.2 on Debian Jessie
###

docker build --build-arg RUBY_VERSION=2.4.2 \
             --build-arg RUBY_EXTRA='-jessie' \
             --build-arg VERSION=0.11.0 \
             --tag 'jdickey/ruby:2.4.2-jessie-no-qt' \
             --squash --file Dockerfile.no-qt.debian .

docker build --build-arg RUBY_VERSION=2.4.2 \
             --build-arg RUBY_EXTRA='-jessie' \
             --build-arg QTLIBS="libqt4-webkit libqt4-dev qt4-qmake" \
             --build-arg VERSION=0.11.0 \
             --tag 'jdickey/ruby:2.4.2-jessie' \
             --squash --file Dockerfile.main.debian .

docker build --build-arg RUBY_VERSION=2.4.2 \
             --build-arg RUBY_EXTRA='-slim-jessie' \
             --build-arg VERSION=0.11.0 \
             --tag 'jdickey/ruby:2.4.2-slim-jessie-no-qt' \
             --squash --file Dockerfile.no-qt.debian .

docker build --build-arg RUBY_VERSION=2.4.2 \
             --build-arg RUBY_EXTRA='-slim-jessie' \
             --build-arg QTLIBS="libqt4-webkit libqt4-dev qt4-qmake" \
             --build-arg VERSION=0.11.0 \
             --tag 'jdickey/ruby:2.4.2-slim-jessie' \
             --squash --file Dockerfile.main.debian .

docker tag jdickey/ruby:2.4.2-jessie jdickey/ruby:2.4.2
docker tag jdickey/ruby:2.4.2 jdickey/ruby:latest
docker tag jdickey/ruby:2.4.2 jdickey/ruby:2
docker tag jdickey/ruby:2.4.2 jdickey/ruby:2.5
docker tag jdickey/ruby:2.4.2 jdickey/ruby:jessie
docker tag jdickey/ruby:2.4.2 jdickey/ruby:2-jessie
docker tag jdickey/ruby:2.4.2 jdickey/ruby:2.5-jessie

docker tag jdickey/ruby:2.4.2-jessie-no-qt jdickey/ruby:2.4.2-no-qt
docker tag jdickey/ruby:2.4.2-no-qt jdickey/ruby:2-no-qt
docker tag jdickey/ruby:2.4.2-no-qt jdickey/ruby:2.5-no-qt
docker tag jdickey/ruby:2.4.2-no-qt jdickey/ruby:2-jessie-no-qt
docker tag jdickey/ruby:2.4.2-no-qt jdickey/ruby:2.5-jessie-no-qt
docker tag jdickey/ruby:2.4.2-no-qt jdickey/ruby:jessie-no-qt

docker tag jdickey/ruby:2.4.2-slim-jessie-no-qt jdickey/ruby:2.4.2-slim-no-qt
docker tag jdickey/ruby:2.4.2-slim-no-qt jdickey/ruby:slim-no-qt
docker tag jdickey/ruby:2.4.2-slim-no-qt jdickey/ruby:2-slim-no-qt
docker tag jdickey/ruby:2.4.2-slim-no-qt jdickey/ruby:2.5-slim-no-qt
docker tag jdickey/ruby:2.4.2-slim-no-qt jdickey/ruby:2-slim-jessie-no-qt
docker tag jdickey/ruby:2.4.2-slim-no-qt jdickey/ruby:2.5-slim-jessie-no-qt
docker tag jdickey/ruby:2.4.2-slim-no-qt jdickey/ruby:slim-jessie-no-qt

docker tag jdickey/ruby:2.4.2-slim-jessie jdickey/ruby:2.4.2-slim
docker tag jdickey/ruby:2.4.2-slim jdickey/ruby:slim
docker tag jdickey/ruby:2.4.2-slim jdickey/ruby:2-slim
docker tag jdickey/ruby:2.4.2-slim jdickey/ruby:2.5-slim
docker tag jdickey/ruby:2.4.2-slim jdickey/ruby:2-slim-jessie
docker tag jdickey/ruby:2.4.2-slim jdickey/ruby:2.5-slim-jessie
docker tag jdickey/ruby:2.4.2-slim jdickey/ruby:slim-jessie

###
### Fin
###

docker image ls --format '{{.ID}}\t{{.Tag}}' | grep none | cut -f 1 | xargs docker image rm

echo 'All images created and tagged.'
echo "Use 'docker image ls jdickey/ruby' to see a complete list."
