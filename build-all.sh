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
#    or '2.5-stretch-no-qt', **must** be synonymous with the _latest_ matching
#    version at the time the image was built.
# 6. An image tag containing *no* Ruby version number *must* match the _latest
#    version of Ruby packaged in the upstream images_ at the time these images
#    were built and tagged.
# 7. If an OS is no longer supported for a given Ruby version upstream (e.g.,
#    'jessie' in previous image builds), then any image built on that OS
#    **must** include a Ruby version number for which that OS is supported. This
#    **may** be a partial version number; e.g., the tag '2.4-jessie-no-qt' was a
#    valid alias for '2.4.4-jessie-no-qt'. However, '2-jessie-no-qt' and
#    'jessie-no-qt' **were not** valid tags once the current Version 2.x release
#    became 2.5.0.
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

for RUBY_VERSION in 2.6.0 2.5.3 2.5.1; do
  for STRETCH in stretch slim-stretch; do
    docker_build $RUBY_VERSION $STRETCH debian no-qt
    docker_build $RUBY_VERSION $STRETCH debian
  done
done

# ############################################################################ #

# Note that, since there is no Alpine 3.8-based image for Ruby 2.5.1, we have to
# adjust our build process here a bit.

for RUBY_VERSION in 2.6.0 2.5.3; do
  for ALPINE_VERSION in 3.7 3.8; do
    docker build --build-arg RUBY_VERSION=$RUBY_VERSION \
                 --build-arg RUBY_EXTRA=$ALPINE_VERSION \
                 --build-arg VERSION=$DOCKER_RUBY_VERSION \
                 --tag "jdickey/ruby:$RUBY_VERSION-alpine$ALPINE_VERSION-no-qt" \
                 --squash --compress --file Dockerfile.no-qt.alpine .
    docker build --build-arg RUBY_VERSION=$RUBY_VERSION \
                 --build-arg RUBY_EXTRA=$ALPINE_VERSION \
                 --build-arg VERSION=$DOCKER_RUBY_VERSION \
                 --tag "jdickey/ruby:$RUBY_VERSION-alpine$ALPINE_VERSION" \
                 --squash --compress --file Dockerfile.main.alpine .
    docker container prune -f && docker image prune -f
  done
done

# Build 2.5.1 for Alpine 3.7 onlyy

docker build --build-arg RUBY_VERSION=2.5.1 \
              --build-arg RUBY_EXTRA=3.7 \
              --build-arg VERSION=$DOCKER_RUBY_VERSION \
              --tag "jdickey/ruby:2.5.1-alpine3.7-no-qt" \
              --squash --compress --file Dockerfile.no-qt.alpine .
docker build --build-arg RUBY_VERSION=2.5.1 \
              --build-arg RUBY_EXTRA=3.7 \
              --build-arg VERSION=$DOCKER_RUBY_VERSION \
              --tag "jdickey/ruby:2.5.1-alpine3.7" \
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
