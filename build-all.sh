#!/bin/bash
set -euo pipefail
#
# Notes on tag naming (copied to 'verify_images' as well):
#
# 1. Each image **should** have one fully-qualified tag; i.e., it contains the
#    full Ruby version number included in the image; identifies the OS it was
#    built with (currently Debian 'stretch' or 'jessie', or 'alpine-3.7'); *and*
#    whether or not it contains Qt/Capybara support (where '-no-qt` indicates
#    that it does not, but see Rule 3).
# 2. The fully-qualified tag mentioned in Rule 1 **may optionally** be the tag
#    initially assigned to the image when it was built.
# 3. An image tag *not* containing either the '-qt' or '-no-qt' indicators
#    **must** be interpreted as the otherwise-equivalent '-qt' image. The
#    explicit tagging of that image with an explicit '-qt' tag is *optional*.
# 4. An image tag without an OS identifier *must be* built on the official
#    Debian OS used for the upstream image: 'jessie' for 2.4.x and earlier, or
#    'stretch' for 2.5.0 and later.
# 5. An image tag containing a _partial_ version number, such as '2-alpine'
#    or '2.4-jessie-no-qt', **must** be synonymous with the _latest_ matching
#    version at the time the image was built. As of April 2018, for the examples
#    given, those would be '2.5.1-alpine-qt' and '2.4.4-jessie-no-qt',
#    respectively.
# 6. An image tag containing *no* Ruby version number *must* match the _latest
#    version of Ruby packaged in the upstream images_ at the time these images
#    were built and tagged.
# 7. If an OS is no longer supported for a given Ruby version upstream (e.g.,
#    'jessie' for Ruby 2.5.0 and later), then any image built on that OS
#    **must** include a Ruby version number for which that OS is supported. This
#    **may** be a partial version number; e.g., the tag '2.4-jessie-no-qt' is a
#    valid alias for (presently) '2.4.4-jessie-no-qt'. However, '2-jessie-no-qt'
#    and 'jessie-no-qt' **are not** valid tags, as the current Version 2.x
#    release (and latest overall) of Ruby is currently 2.5.1.
#

if [[ -z "${DOCKER_RUBY_VERSION}" ]]; then
  echo You MUST define the DOCKER_RUBY_VERSION environment variable when using this script.
  echo It will be encoded into the built images as a version ID.
  echo Example usage: DOCKER_RUBY_VERSION=0.27.0 bash ./build_all.sh
  return 1
fi

###
### 2.5.1 on Debian Stretch
###

docker build --build-arg RUBY_VERSION=2.5.1 \
            --build-arg RUBY_EXTRA='-stretch' \
            --build-arg VERSION=$DOCKER_RUBY_VERSION \
            --tag 'jdickey/ruby:2.5.1-stretch-no-qt' \
            --squash --file Dockerfile.no-qt.debian .

docker build --build-arg RUBY_VERSION=2.5.1 \
             --build-arg RUBY_EXTRA='-stretch' \
             --build-arg QTLIBS="libqtwebkit-dev qt5-qmake" \
             --build-arg VERSION=$DOCKER_RUBY_VERSION \
             --tag 'jdickey/ruby:2.5.1-stretch' \
             --squash --file Dockerfile.main.debian .

docker build --build-arg RUBY_VERSION=2.5.1 \
             --build-arg RUBY_EXTRA='-slim-stretch' \
             --build-arg VERSION=$DOCKER_RUBY_VERSION \
             --tag 'jdickey/ruby:2.5.1-slim-stretch-no-qt' \
             --squash --file Dockerfile.no-qt.debian .

docker build --build-arg RUBY_VERSION=2.5.1 \
             --build-arg RUBY_EXTRA='-slim-stretch' \
             --build-arg QTLIBS="libqtwebkit-dev qt5-qmake" \
             --build-arg VERSION=$DOCKER_RUBY_VERSION \
             --tag 'jdickey/ruby:2.5.1-slim-stretch' \
             --squash --file Dockerfile.main.debian .

###
### 2.5.0 on Debian Stretch
###

docker build --build-arg RUBY_VERSION=2.5.0 \
            --build-arg RUBY_EXTRA='-stretch' \
            --build-arg VERSION=$DOCKER_RUBY_VERSION \
            --tag 'jdickey/ruby:2.5.0-stretch-no-qt' \
            --squash --file Dockerfile.no-qt.debian .

docker build --build-arg RUBY_VERSION=2.5.0 \
             --build-arg RUBY_EXTRA='-stretch' \
             --build-arg QTLIBS="libqtwebkit-dev qt5-qmake" \
             --build-arg VERSION=$DOCKER_RUBY_VERSION \
             --tag 'jdickey/ruby:2.5.0-stretch' \
             --squash --file Dockerfile.main.debian .

docker build --build-arg RUBY_VERSION=2.5.0 \
             --build-arg RUBY_EXTRA='-slim-stretch' \
             --build-arg VERSION=$DOCKER_RUBY_VERSION \
             --tag 'jdickey/ruby:2.5.0-slim-stretch-no-qt' \
             --squash --file Dockerfile.no-qt.debian .

docker build --build-arg RUBY_VERSION=2.5.0 \
             --build-arg RUBY_EXTRA='-slim-stretch' \
             --build-arg QTLIBS="libqtwebkit-dev qt5-qmake" \
             --build-arg VERSION=$DOCKER_RUBY_VERSION \
             --tag 'jdickey/ruby:2.5.0-slim-stretch' \
             --squash --file Dockerfile.main.debian .

###
### 2.5.1 on Alpine 3.7
###

docker build --build-arg RUBY_VERSION=2.5.1 \
             --build-arg RUBY_EXTRA='3.7' \
             --build-arg VERSION=$DOCKER_RUBY_VERSION \
             --tag 'jdickey/ruby:2.5.1-alpine3.7-no-qt' \
             --squash --file Dockerfile.no-qt.alpine .

docker build --build-arg RUBY_VERSION=2.5.1 \
             --build-arg RUBY_EXTRA='3.7' \
             --build-arg VERSION=$DOCKER_RUBY_VERSION \
             --build-arg QTLIBS=qt5-qtwebkit-dev \
             --tag 'jdickey/ruby:2.5.1-alpine3.7' \
             --squash --file Dockerfile.main.alpine .

###
### 2.5.0 on Alpine 3.7
###

docker build --build-arg RUBY_VERSION=2.5.0 \
             --build-arg RUBY_EXTRA='3.7' \
             --build-arg VERSION=$DOCKER_RUBY_VERSION \
             --tag 'jdickey/ruby:2.5.0-alpine3.7-no-qt' \
             --squash --file Dockerfile.no-qt.alpine .

docker build --build-arg RUBY_VERSION=2.5.0 \
             --build-arg RUBY_EXTRA='3.7' \
             --build-arg VERSION=$DOCKER_RUBY_VERSION \
             --build-arg QTLIBS=qt5-qtwebkit-dev \
             --tag 'jdickey/ruby:2.5.0-alpine3.7' \
             --squash --file Dockerfile.main.alpine .

###
### 2.4.4 on Debian Stretch
###

docker build --build-arg RUBY_VERSION=2.4.4 \
             --build-arg RUBY_EXTRA='-stretch' \
             --build-arg VERSION=$DOCKER_RUBY_VERSION \
             --tag 'jdickey/ruby:2.4.4-stretch-no-qt' \
             --squash --file Dockerfile.no-qt.debian .

docker build --build-arg RUBY_VERSION=2.4.4 \
             --build-arg RUBY_EXTRA='-stretch' \
             --build-arg QTLIBS="libqtwebkit-dev qt5-qmake" \
             --build-arg VERSION=$DOCKER_RUBY_VERSION \
             --tag 'jdickey/ruby:2.4.4-stretch' \
             --squash --file Dockerfile.main.debian .

docker build --build-arg RUBY_VERSION=2.4.4 \
             --build-arg RUBY_EXTRA='-slim-stretch' \
             --build-arg VERSION=$DOCKER_RUBY_VERSION \
             --tag 'jdickey/ruby:2.4.4-slim-stretch-no-qt' \
             --squash --file Dockerfile.no-qt.debian .

docker build --build-arg RUBY_VERSION=2.4.4 \
             --build-arg RUBY_EXTRA='-slim-stretch' \
             --build-arg QTLIBS="libqtwebkit-dev qt5-qmake" \
             --build-arg VERSION=$DOCKER_RUBY_VERSION \
             --tag 'jdickey/ruby:2.4.4-slim-stretch' \
             --squash --file Dockerfile.main.debian .

###
### 2.4.4 on Debian Jessie
###

docker build --build-arg RUBY_VERSION=2.4.4 \
             --build-arg RUBY_EXTRA='-jessie' \
             --build-arg VERSION=$DOCKER_RUBY_VERSION \
             --tag 'jdickey/ruby:2.4.4-jessie-no-qt' \
             --squash --file Dockerfile.no-qt.debian .

docker build --build-arg RUBY_VERSION=2.4.4 \
             --build-arg RUBY_EXTRA='-jessie' \
             --build-arg QTLIBS="libqt4-webkit libqt4-dev qt4-qmake" \
             --build-arg VERSION=$DOCKER_RUBY_VERSION \
             --tag 'jdickey/ruby:2.4.4-jessie' \
             --squash --file Dockerfile.main.debian .

docker build --build-arg RUBY_VERSION=2.4.4 \
             --build-arg RUBY_EXTRA='-slim-jessie' \
             --build-arg VERSION=$DOCKER_RUBY_VERSION \
             --tag 'jdickey/ruby:2.4.4-slim-jessie-no-qt' \
             --squash --file Dockerfile.no-qt.debian .

docker build --build-arg RUBY_VERSION=2.4.4 \
             --build-arg RUBY_EXTRA='-slim-jessie' \
             --build-arg QTLIBS="libqt4-webkit libqt4-dev qt4-qmake" \
             --build-arg VERSION=$DOCKER_RUBY_VERSION \
             --tag 'jdickey/ruby:2.4.4-slim-jessie' \
             --squash --file Dockerfile.main.debian .


###
### 2.4.4 on Alpine 3.7
###

docker build --build-arg RUBY_VERSION=2.4.4 \
             --build-arg RUBY_EXTRA='3.7' \
             --build-arg VERSION=$DOCKER_RUBY_VERSION \
             --tag 'jdickey/ruby:2.4.4-alpine3.7-no-qt' \
             --squash --file Dockerfile.no-qt.alpine .

docker build --build-arg RUBY_VERSION=2.4.4 \
             --build-arg RUBY_EXTRA='3.7' \
             --build-arg VERSION=$DOCKER_RUBY_VERSION \
             --build-arg QTLIBS=qt5-qtwebkit-dev \
             --tag 'jdickey/ruby:2.4.4-alpine3.7' \
             --squash --file Dockerfile.main.alpine .

###
### 2.4.3 on Debian Jessie
###

docker build --build-arg RUBY_VERSION=2.4.3 \
             --build-arg RUBY_EXTRA='-jessie' \
             --build-arg VERSION=$DOCKER_RUBY_VERSION \
             --tag 'jdickey/ruby:2.4.3-jessie-no-qt' \
             --squash --file Dockerfile.no-qt.debian .

docker build --build-arg RUBY_VERSION=2.4.3 \
             --build-arg RUBY_EXTRA='-jessie' \
             --build-arg QTLIBS="libqt4-webkit libqt4-dev qt4-qmake" \
             --build-arg VERSION=$DOCKER_RUBY_VERSION \
             --tag 'jdickey/ruby:2.4.3-jessie' \
             --squash --file Dockerfile.main.debian .

docker build --build-arg RUBY_VERSION=2.4.3 \
             --build-arg RUBY_EXTRA='-slim-jessie' \
             --build-arg VERSION=$DOCKER_RUBY_VERSION \
             --tag 'jdickey/ruby:2.4.3-slim-jessie-no-qt' \
             --squash --file Dockerfile.no-qt.debian .

docker build --build-arg RUBY_VERSION=2.4.3 \
             --build-arg RUBY_EXTRA='-slim-jessie' \
             --build-arg QTLIBS="libqt4-webkit libqt4-dev qt4-qmake" \
             --build-arg VERSION=$DOCKER_RUBY_VERSION \
             --tag 'jdickey/ruby:2.4.3-slim-jessie' \
             --squash --file Dockerfile.main.debian .

###
### 2.4.3 on Alpine 3.7
###

docker build --build-arg RUBY_VERSION=2.4.3 \
             --build-arg RUBY_EXTRA='3.7' \
             --build-arg VERSION=$DOCKER_RUBY_VERSION \
             --tag 'jdickey/ruby:2.4.3-alpine3.7-no-qt' \
             --squash --file Dockerfile.no-qt.alpine .

docker build --build-arg RUBY_VERSION=2.4.3 \
             --build-arg RUBY_EXTRA='3.7' \
             --build-arg VERSION=$DOCKER_RUBY_VERSION \
             --build-arg QTLIBS=qt5-qtwebkit-dev \
             --tag 'jdickey/ruby:2.4.3-alpine3.7' \
             --squash --file Dockerfile.main.alpine .

###
### 2.4.2 on Debian Jessie
###

docker build --build-arg RUBY_VERSION=2.4.2 \
             --build-arg RUBY_EXTRA='-jessie' \
             --build-arg VERSION=$DOCKER_RUBY_VERSION \
             --tag 'jdickey/ruby:2.4.2-jessie-no-qt' \
             --squash --file Dockerfile.no-qt.debian .

docker build --build-arg RUBY_VERSION=2.4.2 \
             --build-arg RUBY_EXTRA='-jessie' \
             --build-arg QTLIBS="libqt4-webkit libqt4-dev qt4-qmake" \
             --build-arg VERSION=$DOCKER_RUBY_VERSION \
             --tag 'jdickey/ruby:2.4.2-jessie' \
             --squash --file Dockerfile.main.debian .

docker build --build-arg RUBY_VERSION=2.4.2 \
             --build-arg RUBY_EXTRA='-slim-jessie' \
             --build-arg VERSION=$DOCKER_RUBY_VERSION \
             --tag 'jdickey/ruby:2.4.2-slim-jessie-no-qt' \
             --squash --file Dockerfile.no-qt.debian .

docker build --build-arg RUBY_VERSION=2.4.2 \
             --build-arg RUBY_EXTRA='-slim-jessie' \
             --build-arg QTLIBS="libqt4-webkit libqt4-dev qt4-qmake" \
             --build-arg VERSION=$DOCKER_RUBY_VERSION \
             --tag 'jdickey/ruby:2.4.2-slim-jessie' \
             --squash --file Dockerfile.main.debian .

###
### 2.4.2 on Alpine 3.7
###

docker build --build-arg RUBY_VERSION=2.4.2 \
             --build-arg RUBY_EXTRA='3.7' \
             --build-arg VERSION=$DOCKER_RUBY_VERSION \
             --tag 'jdickey/ruby:2.4.2-alpine3.7-no-qt' \
             --squash --file Dockerfile.no-qt.alpine .

docker build --build-arg RUBY_VERSION=2.4.2 \
             --build-arg RUBY_EXTRA='3.7' \
             --build-arg VERSION=$DOCKER_RUBY_VERSION \
             --build-arg QTLIBS=qt5-qtwebkit-dev \
             --tag 'jdickey/ruby:2.4.2-alpine3.7' \
             --squash --file Dockerfile.main.alpine .

###
### Version tags
###

echo -n "Tagging images..."
./tag_all.rb
echo "Done!"

###
### Fin
###


echo -n 'Failed containers deleted: '
docker container prune -f | grep 'deleted:' | wc -l
echo -n "Temporary images deleted: "
docker image prune -f | grep 'deleted:' | wc -l

echo 'All images created and tagged.'
echo "Use 'docker image ls jdickey/ruby' to see a complete list."
