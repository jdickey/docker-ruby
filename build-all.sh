#!/bin/bash
docker build --squash --tag jdickey/ruby:latest --file 2.4/jessie/Dockerfile .
docker build --squash --tag jdickey/ruby:no-qt --file 2.4/jessie/no-qt/Dockerfile .
docker build --squash --tag jdickey/ruby:slim --file 2.4/jessie/slim/Dockerfile .
docker build --squash --tag jdickey/ruby:slim-no-qt --file 2.4/jessie/slim/no-qt/Dockerfile .

docker tag jdickey/ruby:latest jdickey/ruby:2
docker tag jdickey/ruby:latest jdickey/ruby:2.4
docker tag jdickey/ruby:latest jdickey/ruby:2.4.2
docker tag jdickey/ruby:latest jdickey/ruby:jessie
docker tag jdickey/ruby:latest jdickey/ruby:jessie-2
docker tag jdickey/ruby:latest jdickey/ruby:jessie-2.4
docker tag jdickey/ruby:latest jdickey/ruby:jessie-2.4.2

docker tag jdickey/ruby:no-qt jdickey/ruby:2-no-qt
docker tag jdickey/ruby:no-qt jdickey/ruby:2.4-no-qt
docker tag jdickey/ruby:no-qt jdickey/ruby:2.4.2-no-qt
docker tag jdickey/ruby:no-qt jdickey/ruby:jessie-2-no-qt
docker tag jdickey/ruby:no-qt jdickey/ruby:jessie-2.4-no-qt
docker tag jdickey/ruby:no-qt jdickey/ruby:jessie-2.4.2-no-qt
docker tag jdickey/ruby:no-qt jdickey/ruby:jessie-no-qt

docker tag jdickey/ruby:slim jdickey/ruby:2-slim
docker tag jdickey/ruby:slim jdickey/ruby:2.4-slim
docker tag jdickey/ruby:slim jdickey/ruby:2.4.2-slim
docker tag jdickey/ruby:slim jdickey/ruby:jessie-2-slim
docker tag jdickey/ruby:slim jdickey/ruby:jessie-2.4-slim
docker tag jdickey/ruby:slim jdickey/ruby:jessie-2.4.2-slim
docker tag jdickey/ruby:slim jdickey/ruby:jessie-slim

docker tag jdickey/ruby:slim-no-qt jdickey/ruby:2-slim-no-qt
docker tag jdickey/ruby:slim-no-qt jdickey/ruby:2.4-slim-no-qt
docker tag jdickey/ruby:slim-no-qt jdickey/ruby:2.4.2-slim-no-qt
docker tag jdickey/ruby:slim-no-qt jdickey/ruby:jessie-2-slim-no-qt
docker tag jdickey/ruby:slim-no-qt jdickey/ruby:jessie-2.4-slim-no-qt
docker tag jdickey/ruby:slim-no-qt jdickey/ruby:jessie-2.4.2-slim-no-qt
docker tag jdickey/ruby:slim-no-qt jdickey/ruby:jessie-slim-no-qt
