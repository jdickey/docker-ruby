# [jdickey's Customised Ruby Builds](https://github.com/jdickey/docker-ruby)

# Contents

- [Overview](#overview)
  * [Supported Tags and Respective Dockerfile Links](#supported-tags-and-respective-dockerfile-links)
- [Software](#software)
  * [Debian Stretch or Jessie](#debian-stretch-or-jessie)
    + [Base Software](#base-software)
    + [Qt5 Software (for Stretch)](#qt5-software-for-stretch)
    + [Qt4 Software (for Jessie)](#qt4-software-for-jessie)
  * [Alpine Linux](#alpine-linux)
    + [Base Software](#base-software-1)
    + [Qt5 Software](#qt5-software)
- [Additional Documentation](#additional-documentation)
- [Legal](#legal)

# Overview

I *often* build from Ruby [official base images](https://hub.docker.com/_/ruby/), install additional software packages, and do some basic Ruby housekeeping (installing Bundler and making sure the system Gems are up-to-date). Building against [`2.4.2-jessie`](https://github.com/docker-library/ruby/blob/73d3ed6b06738a7457a24fba9024cad303829c0a/2.4/jessie/Dockerfile) on a 2011 iMac and a decent Net connection, this can take about *20 minutes.* Repeat this half-a-dozen times over the course of a day and you've lost two hours. As Orwell wrote, *doubleplus ungood.*

## Supported Tags and Respective Dockerfile Links

* `2.5.0-stretch`, `2.5-stretch`, `2-stretch`, `stretch`, `2.5.0`, `2.5`, `2`, `latest` ([*2.5.0/stretch/Dockerfile*](https://github.com/jdickey/docker-ruby/blob/master/2.5.0/stretch/Dockerfile))
* `2.5.0-stretch-no-qt`, `2.5-stretch-no-qt`, `2-stretch-no-qt`, `stretch-no-qt`, `2.5.0-no-qt`, `2.5-no-qt`, `2-no-qt` ([*2.5.0/stretch/no-qt/Dockerfile*](https://github.com/jdickey/docker-ruby/blob/master/2.5.0/stretch/no-qt/Dockerfile))
* `2.5.0-slim-stretch`, `2.5-slim-stretch`, `2-slim-stretch`, `slim-stretch`, `2.5.0-slim`, `2.5-slim` ([*2.5.0/stretch/slim/Dockerfile*](https://github.com/jdickey/docker-ruby/blob/master/2.5.0/stretch/slim/Dockerfile))
* `2.5.0-slim-stretch-no-qt`, `2.5-slim-stretch-no-qt`, `2-slim-stretch-no-qt`, `slim-stretch-no-qt`, `2.5.0-slim-no-qt`, `2.5-slim-no-qt`, `2-slim-no-qt`, `slim-no-qt` ([*2.5.0/stretch/slim/no-qt/Dockerfile*](https://github.com/jdickey/docker-ruby/blob/master/2.5.0/stretch/slim/no-qt/Dockerfile))
* `2.5.0-alpine`, `2.5-alpine`, `2-alpine`, `alpine` ([*2.5.0/stretch/Dockerfile*](https://github.com/jdickey/docker-ruby/blob/master/2.5.0/stretch/Dockerfile))
* `2.5.0-alpine-no-qt`, `2.5-alpine-no-qt`, `2-alpine-no-qt`, `alpine-no-qt` ([*2.5.0/alpine/no-qt/Dockerfile*](https://github.com/jdickey/docker-ruby/blob/master/2.5.0/alpine/no-qt/Dockerfile))
* `2.4.3-jessie`, `2.4-jessie`, `2.4.3`, `2.4` ([*2.4.3/jessie/Dockerfile*](https://github.com/jdickey/docker-ruby/blob/master/2.4.3/jessie/Dockerfile))
* `2.4.3-jessie-no-qt`, `2.4-jessie-no-qt`, `2.4.3-no-qt`, `2.4-no-qt` ([*2.4.3/jessie/no-qt/Dockerfile*](https://github.com/jdickey/docker-ruby/blob/master/2.4.3/jessie/no-qt/Dockerfile))
* `2.4.3-slim-jessie`, `2.4-slim-jessie`, `2.4.3-slim`, `2.4-slim` ([*2.4.3/jessie/slim/Dockerfile*](https://github.com/jdickey/docker-ruby/blob/master/2.4.3/jessie/slim/Dockerfile))
* `2.4.3-slim-jessie-no-qt`, `2.4-slim-jessie-no-qt`, `2.4.3-slim-no-qt`, `2.4-slim-no-qt` ([*2.4.3/jessie/slim/no-qt/Dockerfile*](https://github.com/jdickey/docker-ruby/blob/master/2.4.3/jessie/slim/no-qt/Dockerfile))
* `2.4.2-jessie`, `2.4.2` ([*2.4.2/jessie/Dockerfile*](https://github.com/jdickey/docker-ruby/blob/master/2.4.2/jessie/Dockerfile))
* `2.4.2-jessie-no-qt`, `2.4.2-no-qt` ([*2.4.2/jessie/no-qt/Dockerfile*](https://github.com/jdickey/docker-ruby/blob/master/2.4.2/jessie/no-qt/Dockerfile))
* `2.4.2-slim-jessie`, `2.4.2-slim` ([*2.4.2/jessie/slim/Dockerfile*](https://github.com/jdickey/docker-ruby/blob/master/2.4.3/jessie/slim/Dockerfile))
* `2.4.2-slim-jessie-no-qt`, `2.4.2-slim-no-qt` ([*2.4.2/jessie/slim/no-qt/Dockerfile*](https://github.com/jdickey/docker-ruby/blob/master/2.4/jessie/slim/no-qt/Dockerfile))

The `*-no-qt` tags have no version of the Qt GUI libraries installed; those not so marked have Qt5 for (Debian) Stretch and Alpine, and Qt4 for (Debian) Jessie.

There are no "slim" images for Alpine, as the entire point of Alpine is *to be a* minimal base distribution.

Why no tags for, e.g., `2-slim-jessie`? We use tag names intended to be consistent with those of the [official Ruby Docker images](https://hub.docker.com/_/ruby/); the unadorned `2` states that the tag is for the latest 2.*x* Ruby version. All Debian Jessie-based images are for the outdated 2.4.*x* (as of early March 2018, 2.4.3) release. It is possible that some such tags were created in error and not caught prior to release on Docker Hub; if you find one, please [open an issue](https://github.com/jdickey/docker-ruby/issues). *Thanks!*

# Software

## Debian Stretch or Jessie

### Base Software

The following Debian packages are installed in Debian-based images of this repo:

* `build-essential`
* `curl`
* `nodejs`
* `sudo`
* `wget`
* `zsh`

### Qt5 Software (for Stretch)

The following Debian packages are installed in Stretch images not tagged `no-qt` of this repo. This is useful for test-mode builds that include tools such as [Capybara](https://github.com/teamcapybara/capybara):

* `libqtwebkit-dev`
* `libxml2-dev`
* `libxslt1-dev`
* `xvfb`

### Qt4 Software (for Jessie)

The following Debian packages are installed in Jessie images not tagged `no-qt` of this repo. This is useful for test-mode builds that include tools such as [Capybara](https://github.com/teamcapybara/capybara):

* `libqt4-dev`
* `libqt4-webkit`
* `libxml2-dev`
* `libxslt1-dev`
* `xvfb`

## Alpine Linux

### Base Software

The following Alpine packages are installed in Alpine-based images of this repo:

* `alpine-sdk`
* `bash`
* `build-base`
* `nodejs`
* `tzdata`
* `zsh`

### Qt5 Software

The following Alpine packages are installed in Alpine images not tagged `no-qt` of this repo. This is useful for test-mode builds that include tools such as [Capybara](https://github.com/teamcapybara/capybara):

* `libxml2-dev`
* `libxslt-dev`
* `qt5-qtwebkit-dev`
* `xvfb`

# Changelog

## 0.11.0 (4 March 2018)

* **BREAKING CHANGE:** Slim images now named consistently with corresponding official Ruby images; e.g., rather than `2.5.0-stretch-slim`, that image is now tagged `2.5.0-slim-stretch`
* Rearchitected build process to no longer require a separate `Dockerfile` per image being built
* Made base image specs and as-generated image tag more explicit
* Added `yard` and `yard config --gem-install-yri` to `-no-qt` images
* Moved `libxml2-dev` and `libxslt1-dev` packages from `-no-qt` images to Qt/Capybara images, as they are required by Capybara rather than other `-no-qt` packages

## 0.10.0 (1 March 2018)

* Added Ruby 2.4.3 (on Debian Jessie) images
* Reworded `description` label
* Cleaned up package-manager command lines

## 0.9.0 (11 January 2018)

* Qt-included images based on `-no-qt` images, rather than directly on official base image
* Added `LABEL` metadata to built images
* Further cleanup of `Dockerfile`s and build scripts

## 0.8.0 (8 January 2018)

* Added Ruby 2.5.0 (on Debian Stretch and Alpine 3.7) images
* Improved consistency between tag names

## 0.7.0 (17 November 2017)

* Initial release of 2.4 (actually 2.4.2) on Debian Jessie images.

# Additional Documentation

See the [official Ruby Docker image docs](https://hub.docker.com/_/ruby/).

# Legal

All files in this repository are Copyright &copy; 2017 by Jeff Dickey, and licensed under the [MIT License](https://opensource.org/licenses/MIT).

As with all Docker images, these likely also contain other software which may be under other licenses (such as Bash, etc from the base distribution, along with any direct or indirect dependencies of the primary software being contained).

As for any pre-built image usage, it is the image user's responsibility to ensure that any use of this image complies with any relevant licenses for all software contained within.
