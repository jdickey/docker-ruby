# [jdickey's Customised Ruby Builds](https://github.com/jdickey/docker-ruby)

# Contents

- [Overview](#overview)
  * [Supported Tags](#supported-tags)
    + [Logical but Nonexistent Tags](#logical-but-nonexistent-tags)
    + [What? No Dockerfiles?](#what-no-dockerfiles)
- [Software](#software)
  * [Debian Stretch or Jessie](#debian-stretch-or-jessie)
    + [Base Software](#base-software)
    + [Qt5 Software (for Stretch)](#qt5-software-for-stretch)
    + [Qt4 Software (for Jessie)](#qt4-software-for-jessie)
  * [Alpine Linux](#alpine-linux)
    + [Base Software](#base-software-1)
    + [Qt5 Software](#qt5-software)
- [Changelog](#changelog)
  * [0.11.2 (15 March 2018)](#0112-15-march-2018)
  * [0.11.1 (7 March 2018)](#0111-7-march-2018)
  * [0.11.0 (4 March 2018)](#0110-4-march-2018)
  * [0.10.0 (1 March 2018)](#0100-1-march-2018)
  * [0.9.0 (11 January 2018)](#090-11-january-2018)
  * [0.8.0 (8 January 2018)](#080-8-january-2018)
  * [0.7.0 (17 November 2017)](#070-17-november-2017)
- [Additional Documentation](#additional-documentation)
- [Legal](#legal)

# Overview

I *often* build from Ruby [official base images](https://hub.docker.com/_/ruby/), install additional software packages, and do some basic Ruby housekeeping (installing Bundler and making sure the system Gems are up-to-date). Building against [`2.4.2-jessie`](https://github.com/docker-library/ruby/blob/73d3ed6b06738a7457a24fba9024cad303829c0a/2.4/jessie/Dockerfile) on a 2011 iMac and a decent Net connection, this can take about *20 minutes.* Repeat this half-a-dozen times over the course of a day and you've lost two hours. As Orwell wrote, *doubleplus ungood.*

## Supported Tags

Each image has one tag that follows the format `2.x.y-os_build[-no-qt]`, where

1. `2.x.y` is the full version number of the Ruby version hosted by the image, which will be one of `2.5.0` (the current version), `2.4.3`, or `2.4.2`;
2. `os_build` identifies which OS and variant the image was based on. These can be any one of
	1. `jessie`: Debian [Jessie](https://en.wikipedia.org/wiki/Debian#Code_names) (8.0);
	2. `slim-jessie`: A "slim" version of Jessie, containing fewer packages by default (and thus with a considerably smaller image size);
	3. `stretch`: Debian [Stretch](https://en.wikipedia.org/wiki/Debian#Code_names) (9.0);
	4. `stretch-slim`: A "slim" version of Stretch;
	5. `alpine3.7` (synonyms: `alpine37` and `alpine`): Alpine Linux 3.7, a minimalist Linux distribution. (There is no 'slim' version of `alpine`; it's already the smallest of the listed images);
3. The suffix `-no-qt` indicates that the image has been built *without* the Qt OS-level libraries and tools needed to run the [Capybara](https://teamcapybara.github.io/capybara/) test framework (and thus does not include Capybara itself or the `capybara-webkit` headless browser).

The `latest` tag identifies the latest version of Ruby (as of December 2017, version 2.5.0) on the latest, non-`slim` version of Debian (currently `stretch`), built *with* the Qt and Capybara tools. It should be the default choice when you simply want the most recent supported Ruby version, but is not recommended for production use in most cases. (We recommend exploring basing your image on an `alpine` and `-no-qt` build for production.)

Minor-version tags such as `2.4-jessie` or `2.5-alpine-no-qt` identify the latest supported release of that minor version of Ruby on the specified OS build. As later versions of Ruby are released and supported (e.g., a hypothetical 2.4.4 or 2.5.1), the corresponding minor-version tag will be redefined to match the new full-version-number tag.

Major-version tags (e.g., `2-stretch` or `2-alpine3.7`) identify the latest supported minor release of the latest supported major release of Ruby (currently `2.5.0`), and are updated in a manner analogous to minor-version tags; i.e., when Ruby 2.6 is released (expected to be in December, 2018), each major-version tag will be updated to match `2.6.0` on each respective operating system (e.g., `2.6.0-stretch`).

Tags which *do not* include a Ruby version number are built using the latest supported version of Ruby on the OS build identified by their name, e.g., `stretch-no-qt` or `alpine`, built with Qt and Capybara. This differs from `latest` in that `latest` is presently defined as always being on the latest non-`slim` Debian build (currently `stretch`).

Finally, the Alpine Linux OS build names differ from the Debian conventions in that Alpine is the only OS build that encodes (major and minor) version numbers. Hence, `alpine3.7` is synonymous with `alpine37` and, until a newer version of Alpine is supported by the [official Ruby base images](https://hub.docker.com/_/ruby/), `alpine` is as well. That is to say that `2.5.0-alpine3.7` and `alpine` (presently) reference the same image.

### Logical but Nonexistent Tags

Why no tags for, e.g., `2-slim-jessie`? We use tag names intended to be consistent with those of the [official Ruby Docker images](https://hub.docker.com/_/ruby/); the unadorned `2` states that the tag is for the latest 2.*x* Ruby version. No Debian Jessie-based images exist for Ruby versions later than the outdated 2.4.*x* (as of early March 2018, 2.4.3) release. It is possible that some such tags were created in error and not caught prior to release on Docker Hub; if you find one, please [open an issue](https://github.com/jdickey/docker-ruby/issues). *Thanks!*

### What? No Dockerfiles?

Versions of these images prior to [Release 0.11.0](#changelog) published `Dockerfile`s for each supported Ruby version/OS build variant. Release 0.11.0 and later use [Docker build arguments](https://docs.docker.com/engine/reference/commandline/build/#set-build-time-variables---build-arg) to configure the appropriate "template" `Dockerfiles` instead, depending on whether a Debian or Alpine image is being built, with or without Qt and Capybara. These templates are:

* [`Dockerfile.main.alpine`](https://github.com/jdickey/docker-ruby/blob/master/Dockerfile.main.alpine);
* [`Dockerfile.main.debian`](https://github.com/jdickey/docker-ruby/blob/master/Dockerfile.main.debian);
* [`Dockerfile.no-qt.alpine`](https://github.com/jdickey/docker-ruby/blob/master/Dockerfile.no-qt.alpine); and
* [`Dockerfile.no-qt.debian`](https://github.com/jdickey/docker-ruby/blob/master/Dockerfile.no-qt.debian).

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

## 0.11.2 (15 March 2018)

* Corrected ordering of name tokens in Debian 'slim' images. (Fixes Issue #4.)
* Fixed some minor errors in tagging.
* Added, then commented out, building older Ruby versions on Debian Stretch. (See Issue #5.)

## 0.11.1 (7 March 2018)

* Added `2.5.0-alpine37` as synonymous tag for `2.5.0-alpine-3.7`
* Added `2.5.0-alpine37-no-qt-` as synonymous tag for `2.5.0-alpine-3.7-no-qt`

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
