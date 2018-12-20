#!/bin/bash
set -euo pipefail
#
# Notes on tag naming (copied to 'verify_images' as well):
#
# 1. Each image **should** have one fully-qualified tag; i.e., it contains the
#    full Ruby version number included in the image; identifies the OS it was
#    built with (currently Debian 'stretch' or 'alpine-3.7'); *and* whether or
#    not it contains Qt/Capybara support (where '-no-qt` indicates that it does
#    not, but see Rule 3).
# 2. The fully-qualified tag mentioned in Rule 1 **may optionally** be the tag
#    initially assigned to the image when it was built.
# 3. An image tag *not* containing either the '-qt' or '-no-qt' indicators
#    **must** be interpreted as the otherwise-equivalent '-qt' image. The
#    explicit tagging of that image with an explicit '-qt' tag is *optional*.
# 4. An image tag without an OS identifier *must be* built on the official
#    Debian OS used for the upstream image (currently 'stretch'; 'jessie' is no
#    longer supported by these images).
# 5. An image tag containing a _partial_ version number, such as '2-alpine'
#    or '2.4-stretch-no-qt', **must** be synonymous with the _latest_ matching
#    version at the time the image was built. As of April 2018, for the examples
#    given, those would be '2.5.3-alpine-qt' and '2.4.4-stretch-no-qt',
#    respectively.
# 6. An image tag containing *no* Ruby version number *must* match the _latest
#    version of Ruby packaged in the upstream images_ at the time these images
#    were built and tagged.
# 7. If an OS is no longer supported for a given Ruby version upstream (e.g.,
#    'jessie' in previous image builds), then any image built on that OS
#    **must** include a Ruby version number for which that OS is supported. This
#    **may** be a partial version number; e.g., the tag '2.4-jessie-no-qt' was a
#    valid alias for '2.4.4-jessie-no-qt'. However, '2-jessie-no-qt' and
#    'jessie-no-qt' **were not** valid tags once the current Version 2.x release
#    became 2.5.0. (The latest overall version of Ruby is currently 2.5.1.)
#

if [[ -z "${DOCKER_RUBY_VERSION}" ]]; then
  echo You MUST define the DOCKER_RUBY_VERSION environment variable when using this script.
  echo It will be encoded into the built images as a version ID.
  echo Example usage: DOCKER_RUBY_VERSION=0.27.0 bash ./build_all.sh
  sleep 3
  return 1
fi

function docker_build() {
  local TAG_EXTRA=''
  local FILE_VARIANT='main'

  if [[ ${4:-oops} == 'no-qt' ]]; then
    TAG_EXTRA='-no-qt'
    FILE_VARIANT='no-qt'
  fi

  docker build --build-arg RUBY_VERSION=$1 \
               --build-arg RUBY_EXTRA="-$2" \
               --build-arg VERSION=$DOCKER_RUBY_VERSION \
               --tag "jdickey/ruby:$1-$2$TAG_EXTRA" \
               --squash --compress --file Dockerfile.$FILE_VARIANT.$3 .
}

# ############################################################################ #

###
### Debian Stretch
###

for RUBY_VERSION in 2.5.3 2.5.1 2.5.0 2.4.5 2.4.4; do
  for STRETCH in stretch slim-stretch; do
    docker_build $RUBY_VERSION $STRETCH debian no-qt
    docker_build $RUBY_VERSION $STRETCH debian
  done
done

# ############################################################################ #

# When building 0.14.0, putting a `docker_build` function together that worked
# for Stretch wasn't too tough; I kept tripping over one thing or another trying
# to replicate it for Alpine and gave up after a dozen tries. I'll get it right
# another time.
#
# Why bother, you ask? Look at what it takes to build Stretch images compared to
# how Alpine images are built, and consider adding a new Ruby version to each.
# There's a typo that you've managed to introduce into each. Which do you think
# is going to be the *easier* of the two tpyos to find and repair?

###
### 2.5.3 on Alpine 3.7
###

docker build --build-arg RUBY_VERSION=2.5.3 \
             --build-arg RUBY_EXTRA='3.7' \
             --build-arg VERSION=$DOCKER_RUBY_VERSION \
             --tag 'jdickey/ruby:2.5.3-alpine3.7-no-qt' \
             --squash --compress --file Dockerfile.no-qt.alpine .

docker build --build-arg RUBY_VERSION=2.5.3 \
             --build-arg RUBY_EXTRA='3.7' \
             --build-arg VERSION=$DOCKER_RUBY_VERSION \
             --tag 'jdickey/ruby:2.5.3-alpine3.7' \
             --squash --compress --file Dockerfile.main.alpine .
docker container prune -f && docker image prune -f

###
### 2.5.1 on Alpine 3.7
###

docker build --build-arg RUBY_VERSION=2.5.1 \
             --build-arg RUBY_EXTRA='3.7' \
             --build-arg VERSION=$DOCKER_RUBY_VERSION \
             --tag 'jdickey/ruby:2.5.1-alpine3.7-no-qt' \
             --squash --compress --file Dockerfile.no-qt.alpine .

docker build --build-arg RUBY_VERSION=2.5.1 \
             --build-arg RUBY_EXTRA='3.7' \
             --build-arg VERSION=$DOCKER_RUBY_VERSION \
             --tag 'jdickey/ruby:2.5.1-alpine3.7' \
             --squash --compress --file Dockerfile.main.alpine .
docker container prune -f && docker image prune -f

###
### 2.5.0 on Alpine 3.7
###

docker build --build-arg RUBY_VERSION=2.5.0 \
             --build-arg RUBY_EXTRA='3.7' \
             --build-arg VERSION=$DOCKER_RUBY_VERSION \
             --tag 'jdickey/ruby:2.5.0-alpine3.7-no-qt' \
             --squash --compress --file Dockerfile.no-qt.alpine .

docker build --build-arg RUBY_VERSION=2.5.0 \
             --build-arg RUBY_EXTRA='3.7' \
             --build-arg VERSION=$DOCKER_RUBY_VERSION \
             --tag 'jdickey/ruby:2.5.0-alpine3.7' \
             --squash --compress --file Dockerfile.main.alpine .
docker container prune -f && docker image prune -f

###
### 2.4.5 on Alpine 3.7
###

docker build --build-arg RUBY_VERSION=2.4.5 \
             --build-arg RUBY_EXTRA='3.7' \
             --build-arg VERSION=$DOCKER_RUBY_VERSION \
             --tag 'jdickey/ruby:2.4.5-alpine3.7-no-qt' \
             --squash --compress --file Dockerfile.no-qt.alpine .

docker build --build-arg RUBY_VERSION=2.4.5 \
             --build-arg RUBY_EXTRA='3.7' \
             --build-arg VERSION=$DOCKER_RUBY_VERSION \
             --tag 'jdickey/ruby:2.4.5-alpine3.7' \
             --squash --compress --file Dockerfile.main.alpine .
docker container prune -f && docker image prune -f

###
### 2.4.4 on Alpine 3.7
###

docker build --build-arg RUBY_VERSION=2.4.4 \
             --build-arg RUBY_EXTRA='3.7' \
             --build-arg VERSION=$DOCKER_RUBY_VERSION \
             --tag 'jdickey/ruby:2.4.4-alpine3.7-no-qt' \
             --squash --compress --file Dockerfile.no-qt.alpine .

docker build --build-arg RUBY_VERSION=2.4.4 \
             --build-arg RUBY_EXTRA='3.7' \
             --build-arg VERSION=$DOCKER_RUBY_VERSION \
             --tag 'jdickey/ruby:2.4.4-alpine3.7' \
             --squash --compress --file Dockerfile.main.alpine .
docker container prune -f && docker image prune -f

###
### Version tags
###

echo -n "Tagging images..."
./tag_all.rb
echo "Done!"

###
### Fin
###

echo 'All images created and tagged.'
echo "Use 'docker image ls jdickey/ruby' to see a complete list."
docker image tag jdickey/ruby:2.5.3-stretch jdickey/ruby:latest
