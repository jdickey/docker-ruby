#!/bin/bash
set -euo pipefail
#
# Notes on tag naming:
#
# 1. Each image **must** have one fully-qualified tag; i.e., it contains the
#    full Ruby version number included in the image; identifies the OS it was
#    built with (currently Debian 'stretch' or 'alpine-3.8').
# 2. The fully-qualified tag mentioned in Rule 1 **may optionally** be the tag
#    initially assigned to the image when it was built.
# 3. An image tag without an OS identifier *must be* built on the official
#    Debian OS used for the upstream image (currently 'stretch'; 'jessie' is no
#    longer supported by these images).
# 5. An image tag containing a _partial_ version number, such as '2-alpine'
#    or '2.5-stretch', **must** be synonymous with the _latest_ matching version
#    for that base OS at the time the image was built.
# 6. An image tag containing *no* Ruby version number *must* match the _latest
#    version of Ruby packaged in the upstream images_ at the time these images
#    were built and tagged.
#

function docker_build() {
  docker build --build-arg RUBY_VERSION=$1 \
               --build-arg RUBY_EXTRA="-$2" \
               --build-arg VERSION=$DOCKER_RUBY_VERSION \
               --tag "jdickey/ruby:$1-$2" \
               --squash --compress --file debian.dockerfile .
}

if [[ -z $DOCKER_RUBY_VERSION ]]; then
  echo You MUST define the DOCKER_RUBY_VERSION environment variable when using this script.
  echo It will be encoded into the built images as a version ID.
  echo Example usage: DOCKER_RUBY_VERSION=0.77.0 bash ./build_all.sh
  sleep 3
  exit 1
fi

# ############################################################################ #

###
### Build images for Debian and Alpine
###

for RUBY_VERSION in 2.6.4 2.5.6; do
  for STRETCH in stretch slim-stretch; do
    docker_build $RUBY_VERSION $STRETCH
  done

  for ALPINE_VERSION in 3.9; do
    docker build --build-arg RUBY_VERSION=$RUBY_VERSION \
                 --build-arg RUBY_EXTRA=$ALPINE_VERSION \
                 --build-arg VERSION=$DOCKER_RUBY_VERSION \
                 --tag "jdickey/ruby:$RUBY_VERSION-alpine$ALPINE_VERSION" \
                 --squash --compress --file alpine.dockerfile .
    docker container prune -f && docker image prune -f
  done
done

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
