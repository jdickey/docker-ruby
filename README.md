# [jdickey's Customised Ruby Builds](https://github.com/jdickey/docker-ruby)

[![Join the chat at https://gitter.im/docker-ruby/community](https://badges.gitter.im/docker-ruby/community.svg)](https://gitter.im/docker-ruby/community?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

# Contents


* [Overview](#overview)
  * [IMPORTANT NOTES](#important-notes)
    * [Deprecation Notices](#deprecation-notices)
    * [Changes in Gems Within Images](#changes-in-gems-within-images)
    * [Removal of capybara-webkit and supporting json](#removal-of-capybara-webkit-and-supporting-json)
    * [New Images](#new-images)
    * [Removed Images](#removed-images)
  * [Supported Tags](#supported-tags)
    * [Logical but Nonexistent Tags](#logical-but-nonexistent-tags)
    * [What? No Dockerfiles?](#what-no-dockerfiles)
* [Software](#software)
  * [Debian Stretch](#debian-stretch)
    * [Base Software](#base-software)
    * [Qt5 Software](#qt5-software)
  * [Alpine Linux](#alpine-linux)
    * [Base Software](#base-software-1)
    * [Qt5 Software](#qt5-software-1)
* [Changelog](#changelog)
  * [0.15.1 (9 January 2019)](#0151-9-january-2019)
  * [0.15.0 (29 December 2018)](#0150-29-december-2018)
  * [0.14.2 (28 December 2018)](#0142-28-december-2018)
  * [0.14.1 (20 December 2018)](#0141-20-december-2018)
  * [0.14.0 (19 October 2018)](#0140-19-october-2018)
  * [0.13.4 (10 October 2018)](#0134-10-october-2018)
  * [0.13.3 (24 September 2018)](#0133-24-september-2018)
  * [0.13.2 (20 September 2018)](#0132-20-september-2018)
  * [0.13.1 (24 June 2018)](#0131-24-june-2018)
  * [0.13.0 (11 June 2018)](#0130-11-june-2018)
  * [0.12.0 (11 April 2018) WITHDRAWN — DO NOT USE](#0120-11-april-2018-withdrawn--do-not-use)
  * [0.11.2 (15 March 2018)](#0112-15-march-2018)
  * [0.11.1 (7 March 2018)](#0111-7-march-2018)
  * [0.11.0 (4 March 2018)](#0110-4-march-2018)
  * [0.10.0 (1 March 2018)](#0100-1-march-2018)
  * [0.9.0 (11 January 2018)](#090-11-january-2018)
  * [0.8.0 (8 January 2018)](#080-8-january-2018)
  * [0.7.0 (17 November 2017)](#070-17-november-2017)
* [Additional Documentation](#additional-documentation)
* [Legal](#legal)

Created by [gh-md-toc](https://github.com/ekalinin/github-markdown-toc.go)

# Overview

I *often* build from Ruby [official base images](https://hub.docker.com/_/ruby/), install additional software packages, and do some basic Ruby housekeeping (installing Bundler and making sure the system Gems are up-to-date). On a reasonably modern iMac with a decent First World internet connection, this can take about *20 minutes.* Repeat this half-a-dozen times over the course of a day and you've lost two hours. As Orwell wrote, *doubleplus ungood.*

## IMPORTANT NOTES

### Deprecation Notices

Version 0.16.0 will drop support for Ruby 2.5.1, as well as for images built using Alpine Linux 3.7 (in favour of Alpine 3.8).

### Changes in Gems Within Images

### Removal of `capybara-webkit` and supporting `json`

With effect from Version 0.15.0, the Qt-including images (e.g., `2.6.0-stretch` or `2.5.1-alpine3.8`) no longer include `capybara-webkit` or its supporting `json` Gem. `capybara-webkit` has given us and countless other teams ulcers for quite some time, and our own downstream projects no longer use it (in favour of Capybara+Selenium presently, but [Rubium](https://github.com/vifreefly/rubium)) is firmly in the "assess" ring of our technology radar.)

Does this mean that we'll stop building Qt-including images entirely? **Almost certainly with Version 0.16.0 or, at least 0.17.0;** as the only major remaining Gem installed is `capybara`, which doesn't itself even _require_ Qt. Our feeling is that simplifying this image's build management by pushing installation of `capybara` and Qt to higher-level images that actually _use_ them (or supporting images used in conjuction with them) would be a net positive for us.

### New Images

Version 0.15.0 adds support for Ruby 2.6.0 (which is also tagged as `2` and `default`). Ruby versions 2.5.3 (also tagged as `2.5`) and 2.5.1 are also still included.

### Removed Images

Version 0.15.0 removes support for Ruby versions 2.5.0, 2.4.5 and 2.4.4. Version 2.4.5 now has two major-for-Ruby versions superseding it (2.5 and 2.6); if you haven't upgraded in the last year, now's the time. Version 2.5.0 has had two security/bug-fix patch versions since (2.5.1 and 2.5.3); if you absolutely need to support outdated/known-insecure versions of Ruby, then [the upstream official images](https://hub.docker.com/_/ruby/) are what you want, and even they're discouraging people from using the latest releases.

Also, note that there is **no** upstream `ruby:2.5.1-alpine3.8` image, so we have none here. (Ruby 2.5.1 was released in March, 2018; Alpine 3.8 was first released that June. The upstream maintainers apparently feel that a 2.5.1-on-3.8 release would be anachronistic, and we do not disagree with that assessment.)

## Supported Tags

Each image has one tag that follows the format `2.x.y-os_build[-no-qt]`, where

1. `2.x.y` is the full version number of the Ruby version hosted by the image, which will be one of `2.6.0` (the current version), `2.5.3` (the current `2.5` release), or`2.5.1`. Again, you are **strongly urged** not to use releases prior to the latest release on a given version branch (`2.6` or `2.5`) for new images;
2. `os_build` identifies which OS and variant the image was based on. These can be any one of
	1. `stretch`: Debian [Stretch](https://en.wikipedia.org/wiki/Debian#Code_names) (9.0);
	2. `stretch-slim`: A "slim" version of Stretch;
	3. `alpine3.8` (synonyms: `alpine38` and `alpine`): Alpine Linux 3.8, a minimalist Linux distribution. (There is no 'slim' version of `alpine`; it's already the smallest of the listed images);
	3. `alpine3.7` (synonym: `alpine37`): Alpine Linux 3.7, the previous default Alpine version. Now that all upstream images we use support Alpine 3.8, this is being deprecated.
3. The suffix `-no-qt` indicates that the image has been built *without* the Qt OS-level libraries and tools commonly used with testing using the [Capybara](https://teamcapybara.github.io/capybara/) test framework and add-ons.

The `latest` tag identifies the latest version of Ruby (as of December 2018, version 2.6.0) on the latest, non-`slim` version of Debian (currently `stretch`), built *with* the Qt and Capybara tools. It should be the default choice when you simply want the most recent supported Ruby version, but is not recommended for production use in most cases. (We recommend exploring basing your image on an `alpine` and `-no-qt` build for production.)

Minor-version tags such as `2.6-stretch` or `2.5-alpine-no-qt` identify the latest supported release of that minor version of Ruby on the specified OS build. As later versions of Ruby are released and supported (e.g., a hypothetical 2.6.1 or 2.5.4), the corresponding minor-version tag will be redefined to match the new full-version-number tag.

Major-version tags (e.g., `2-stretch` or `2-alpine3.8`) identify the latest supported minor release of the latest supported major release of Ruby (currently `2.6.0`), and are updated in a manner analogous to minor-version tags; i.e., when Ruby 2.7 is released (expected to be in December, 2019), each major-version tag will be updated to match `2.7.0` on each respective operating system (e.g., `2.7.0-stretch`).

Tags which *do not* include a Ruby version number are built using the latest supported version of Ruby on the OS build identified by their name, e.g., `stretch` or `alpine`, built with Qt and Capybara. This differs from `latest` in that `latest` is presently defined as always being on the latest non-`slim` Debian build (currently `stretch`).

Finally, the Alpine Linux OS build names differ from the Debian conventions in that Alpine is the only OS build that encodes (major and minor) version numbers. Hence, `alpine3.8` is synonymous with `alpine38` and, until a newer version of Alpine is supported by the [official Ruby base images](https://hub.docker.com/_/ruby/), `alpine` is as well. That is to say that `2.6.0-alpine3.8` and `alpine` (presently) reference the same image.

### Logical but Nonexistent Tags

Why no tags for, e.g., `2-slim-jessie`? First, support for Jessie is dead; as of September, 2018, all Debian builds are on Stretch. We use tag names intended to be consistent with those of the [official Ruby Docker images](https://hub.docker.com/_/ruby/); the unadorned `2` states that the tag is for the latest 2.*x* Ruby version. No Debian Jessie-based images should exist for any Ruby version. It is possible that some such tags were created in error and not caught prior to release on Docker Hub; if you find one, please [open an issue](https://github.com/jdickey/docker-ruby/issues). *Thanks!*

### What? No Dockerfiles?

Versions of these images prior to [Release 0.11.0](#changelog) published `Dockerfile`s for each supported Ruby version/OS build variant. Release 0.11.0 and later use [Docker build arguments](https://docs.docker.com/engine/reference/commandline/build/#set-build-time-variables---build-arg) to configure the appropriate "template" `Dockerfiles` instead, depending on whether a Debian or Alpine image is being built, with or without Qt and Capybara. These templates are:

* [`Dockerfile.main.alpine`](https://github.com/jdickey/docker-ruby/blob/master/Dockerfile.main.alpine);
* [`Dockerfile.main.debian`](https://github.com/jdickey/docker-ruby/blob/master/Dockerfile.main.debian);
* [`Dockerfile.no-qt.alpine`](https://github.com/jdickey/docker-ruby/blob/master/Dockerfile.no-qt.alpine); and
* [`Dockerfile.no-qt.debian`](https://github.com/jdickey/docker-ruby/blob/master/Dockerfile.no-qt.debian).

# Software

## Debian Stretch

Jessie is dead; long live Stretch! Ancient, now-unsupported upstream official Ruby images were based on Debian Jessie; however, we no longer build Ruby images based on these no-longer-supported Ruby versions.

### Base Software

The following Debian packages are installed in Debian-based images of this repo:

* `build-essential`
* `curl`
* `nodejs`
* `sudo`
* `wget`
* `zsh`

### Qt5 Software

The following Debian packages are installed in all Debian images not tagged `no-qt` of this repo. This is useful for test-mode builds that include tools such as [Capybara](https://github.com/teamcapybara/capybara):

* `libqt5webkit5-dev`
* `qt5-qmake`
* `libqtwebkit-dev`
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

## 0.15.1 (9 January 2019)

Our first release of the New Year is a Gem-version bump, bringing Bundler to Version 2.0.1 and Nokogiri to Version 1.10.0. No other changes have been made; importantly, Ruby 2.5.1 is still supported for you laggards.

## 0.15.0 (29 December 2018)

Yes, that was fast. There now *are* Ruby 2.6.0 official upstream images (should have waited a day); as promised in the 0.14.2 release notes, here we are.

Besides Ruby 2.6.0, this version introduces several changes to the built images; see [IMPORTANT NOTES](#important-notes), above.

## 0.14.2 (28 December 2018)

We've updated Gems again (including `bundler` and RubyGems itself). There isn't yet an official Ruby 2.6.0 upstream image yet; that will be the base for 0.15.0 as soon as it's available.

## 0.14.1 (20 December 2018)

* Added "Important Notes" subsection _For Versions 0.15.0 and Later_; **please read**;
* Updated Gem versions.

## 0.14.0 (19 October 2018)

* Introduced images built on Ruby versions 2.5.3 and 2.4.5.
* Reworded the README to emphasise the urgency of using outdated Ruby versions only for testing.

## 0.13.4 (10 October 2018)

* No images based on Debian Jessie are supported as of this release;
* Installed (then-)current version of Bundler into default Gem set;
* Updated now-outdated `capybara`, `capybara-webkit`, and `nokogiri` Gems.

## 0.13.3 (24 September 2018)

* Added new `jdickey_ruby_image_version` label with same content as `version`. The latter may (should?) be overwritten by subsequent images using this as a base; the former ought not to be;
* Updated now-outdated Gem versions.

## 0.13.2 (20 September 2018)

* Ruby versions prior to 2.4.4 are *no longer built as images*. Consequently, all upstream images based on Debian support Stretch, and so all Jessie builds (as well as Alpine builds of Ruby versions prior to 2.4.4) have been dropped.

## 0.13.1 (24 June 2018)

* Ruby <= 2.4.4 on Debian Jessie fixed upstream (but still to be removed on or after 11 September 2018).

## 0.13.0 (11 June 2018)

* Corrected Qt5 library specification, eliminating Qt4.
* Simplified image-build process.
* Added deprecation notice for Ruby < 2.4.4 to this README.

## 0.12.0 (11 April 2018) WITHDRAWN &mdash; DO NOT USE

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

All files in this repository are Copyright &copy; 2017-2018 by Jeff Dickey, and licensed under the [MIT License](https://opensource.org/licenses/MIT).

As with all Docker images, these likely also contain other software which may be under other licenses (such as Bash, etc from the base distribution, along with any direct or indirect dependencies of the primary software being contained).

As for any pre-built image usage, it is the image user's responsibility to ensure that any use of this image complies with any relevant licenses for all software contained within.
