#!/bin/bash
docker build --squash --tag jdickey/ruby:2.5.0-no-qt --file ./stretch/no-qt/Dockerfile .
docker build --squash --tag jdickey/ruby:2.5.0 --file ./stretch/Dockerfile .
docker build --squash --tag jdickey/ruby:2.5.0-slim-no-qt --file ./stretch/slim/no-qt/Dockerfile .
docker build --squash --tag jdickey/ruby:2.5.0-slim --file ./stretch/slim/Dockerfile .
docker build --squash --tag jdickey/ruby:2.5.0-alpine-no-qt --file ./alpine/no-qt/Dockerfile .
docker build --squash --tag jdickey/ruby:2.5.0-alpine --file ./alpine/Dockerfile .

docker tag jdickey/ruby:2.5.0 jdickey/ruby:latest
docker tag jdickey/ruby:2.5.0 jdickey/ruby:2
docker tag jdickey/ruby:2.5.0 jdickey/ruby:2.5
# docker tag jdickey/ruby:2.5.0 jdickey/ruby:2.5.0
docker tag jdickey/ruby:2.5.0 jdickey/ruby:stretch
docker tag jdickey/ruby:2.5.0 jdickey/ruby:2-stretch
docker tag jdickey/ruby:2.5.0 jdickey/ruby:2.5-stretch
docker tag jdickey/ruby:2.5.0 jdickey/ruby:2.5.0-stretch

docker tag jdickey/ruby:2.5.0-no-qt jdickey/ruby:2-no-qt
docker tag jdickey/ruby:2.5.0-no-qt jdickey/ruby:2.5-no-qt
# docker tag jdickey/ruby:2.5.0-no-qt jdickey/ruby:2.5.0-no-qt
docker tag jdickey/ruby:2.5.0-no-qt jdickey/ruby:2-stretch-no-qt
docker tag jdickey/ruby:2.5.0-no-qt jdickey/ruby:2.5-stretch-no-qt
docker tag jdickey/ruby:2.5.0-no-qt jdickey/ruby:2.5.0-stretch-no-qt
docker tag jdickey/ruby:2.5.0-no-qt jdickey/ruby:stretch-no-qt

docker tag jdickey/ruby:2.5.0-slim jdickey/ruby:2-slim
docker tag jdickey/ruby:2.5.0-slim jdickey/ruby:2.5-slim
# docker tag jdickey/ruby:2.5.0-slim jdickey/ruby:2.5.0-slim
docker tag jdickey/ruby:2.5.0-slim jdickey/ruby:2-stretch-slim
docker tag jdickey/ruby:2.5.0-slim jdickey/ruby:2.5-stretch-slim
docker tag jdickey/ruby:2.5.0-slim jdickey/ruby:2.5.0-stretch-slim
docker tag jdickey/ruby:2.5.0-slim jdickey/ruby:stretch-slim

docker tag jdickey/ruby:2.5.0-slim-no-qt jdickey/ruby:slim-no-qt
docker tag jdickey/ruby:2.5.0-slim-no-qt jdickey/ruby:2-slim-no-qt
docker tag jdickey/ruby:2.5.0-slim-no-qt jdickey/ruby:2.5-slim-no-qt
# docker tag jdickey/ruby:2.5.0-slim-no-qt jdickey/ruby:2.5.0-slim-no-qt
docker tag jdickey/ruby:2.5.0-slim-no-qt jdickey/ruby:2-stretch-slim-no-qt
docker tag jdickey/ruby:2.5.0-slim-no-qt jdickey/ruby:2.5-stretch-slim-no-qt
docker tag jdickey/ruby:2.5.0-slim-no-qt jdickey/ruby:2.5.0-stretch-slim-no-qt
docker tag jdickey/ruby:2.5.0-slim-no-qt jdickey/ruby:stretch-slim-no-qt

docker tag jdickey/ruby:2.5.0-alpine jdickey/ruby:2.5-alpine
docker tag jdickey/ruby:2.5.0-alpine jdickey/ruby:2-alpine
docker tag jdickey/ruby:2.5.0-alpine jdickey/ruby:alpine

docker tag jdickey/ruby:2.5.0-alpine-no-qt jdickey/ruby:2.5-alpine-no-qt
docker tag jdickey/ruby:2.5.0-alpine-no-qt jdickey/ruby:2-alpine-no-qt
docker tag jdickey/ruby:2.5.0-alpine-no-qt jdickey/ruby:alpine-no-qt
