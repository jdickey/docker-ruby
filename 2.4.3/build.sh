#!/bin/bash
docker build --squash --tag jdickey/ruby:2.4.3-no-qt --file ./jessie/no-qt/Dockerfile .
docker build --squash --tag jdickey/ruby:2.4.3 --file ./jessie/Dockerfile .
docker build --squash --tag jdickey/ruby:2.4.3-slim-no-qt --file ./jessie/slim/no-qt/Dockerfile .
docker build --squash --tag jdickey/ruby:2.4.3-slim --file ./jessie/slim/Dockerfile .

docker tag jdickey/ruby:2.4.3 jdickey/ruby:2.4
docker tag jdickey/ruby:2.4.3 jdickey/ruby:2.4-jessie
docker tag jdickey/ruby:2.4.3 jdickey/ruby:2.4.3-jessie

docker tag jdickey/ruby:2.4.3-no-qt jdickey/ruby:2.4-no-qt
docker tag jdickey/ruby:2.4.3-no-qt jdickey/ruby:2.4-jessie-no-qt
docker tag jdickey/ruby:2.4.3-no-qt jdickey/ruby:2.4.3-jessie-no-qt

docker tag jdickey/ruby:2.4.3-slim jdickey/ruby:2.4-slim
docker tag jdickey/ruby:2.4.3-slim jdickey/ruby:2.4-jessie-slim
docker tag jdickey/ruby:2.4.3-slim jdickey/ruby:2.4.3-jessie-slim

docker tag jdickey/ruby:2.4.3-slim-no-qt jdickey/ruby:2.4-slim-no-qt
docker tag jdickey/ruby:2.4.3-slim-no-qt jdickey/ruby:2.4-jessie-slim-no-qt
docker tag jdickey/ruby:2.4.3-slim-no-qt jdickey/ruby:2.4.3-jessie-slim-no-qt
