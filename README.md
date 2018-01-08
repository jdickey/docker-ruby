<h1>jdickey's Customised Ruby Builds</h1>

<h1>Contents</h1>

- [Overview](#overview)
- [Software](#software)
  * [Base Software](#base-software)
  * [Qt4 Software](#qt4-software)
- [Additional Documentation](#additional-documentation)
- [Legal](#legal)

# Overview

I *often* build from Ruby [official base images](https://hub.docker.com/_/ruby/), install additional software packages, and do some basic Ruby housekeeping (installing Bundler and making sure the system Gems are up-to-date). Building against [`2.4.2-jessie`](https://github.com/docker-library/ruby/blob/73d3ed6b06738a7457a24fba9024cad303829c0a/2.4/jessie/Dockerfile) on a 2011 iMac and a decent Net connection, this can take about *20 minutes.* Repeat this half-a-dozen times over the course of a day and you've lost two hours. As Orwell wrote, *doubleplus ungood.*

## Supported Tags and Respective Dockerfile Links

* `2.5.0-stretch`, `2.5-stretch`, `2-stretch`, `stretch`, `2.5.0`, `2.5`, `2`, `latest` ([*2.5.0/stretch/Dockerfile*](https://github.com/jdickey/docker-ruby/blob/master/2.5.0/stretch/Dockerfile))
* `2.5.0-stretch-no-qt`, `2.5-stretch-no-qt`, `2-stretch-no-qt`, `stretch-no-qt`, `2.5.0-no-qt`, `2.5-no-qt` ([*2.5.0/stretch/no-qt/Dockerfile*](https://github.com/jdickey/docker-ruby/blob/master/2.5.0/stretch/no-qt/Dockerfile))
* `2.5.0-stretch-slim`, `2.5-stretch-slim`, `2-stretch-slim`, `stretch-slim`, `2.5.0-slim`, `2.5-slim` ([*2.5.0/stretch/slim/Dockerfile*](https://github.com/jdickey/docker-ruby/blob/master/2.5.0/stretch/slim/Dockerfile))
* `2.5.0-stretch-slim-no-qt`, `2.5-stretch-slim-no-qt`, `2-stretch-slim-no-qt`, `stretch-slim-no-qt`, `2.5.0-slim-no-qt`, `2.5-slim-no-qt` ([*2.5.0/stretch/slim/no-qt/Dockerfile*](https://github.com/jdickey/docker-ruby/blob/master/2.5.0/stretch/slim/no-qt/Dockerfile))
* `2.5.0-alpine`, `2.5-alpine`, `2-alpine`, `alpine` ([*2.5.0/stretch/Dockerfile*](https://github.com/jdickey/docker-ruby/blob/master/2.5.0/stretch/Dockerfile))
* `2.5.0-alpine-no-qt`, `2.5-alpine-no-qt`, `2-alpine-no-qt`, `alpine-no-qt` ([*2.5.0/alpine/no-qt/Dockerfile*](https://github.com/jdickey/docker-ruby/blob/master/2.5.0/alpine/no-qt/Dockerfile))
* `2.4.2-jessie`, `2.4-jessie`, `2-jessie`, `jessie`, `2.4.2`, `2.4` ([*2.4/jessie/Dockerfile*](https://github.com/jdickey/docker-ruby/blob/master/2.4/jessie/Dockerfile))
* `2.4.2-jessie-no-qt`, `2.4-jessie-no-qt`, `2-jessie-no-qt`, `jessie-no-qt`, `2.4.2-no-qt`, `2.4-no-qt` ([*2.4/jessie/no-qt/Dockerfile*](https://github.com/jdickey/docker-ruby/blob/master/2.4/jessie/no-qt/Dockerfile))
* `2.4.2-jessie-slim`, `2.4-jessie-slim`, `2-jessie-slim`, `jessie-slim`, `2.4.2-slim`, `2.4-slim` ([*2.4/jessie/slim/Dockerfile*](https://github.com/jdickey/docker-ruby/blob/master/2.4/jessie/slim/Dockerfile))
* `2.4.2-jessie-slim-no-qt`, `2.4-jessie-slim-no-qt`, `2-jessie-slim-no-qt`, `jessie-slim-no-qt`, `2.4.2-slim-no-qt`, `2.4-slim-no-qt` ([*2.4/jessie/slim/no-qt/Dockerfile*](https://github.com/jdickey/docker-ruby/blob/master/2.4/jessie/slim/no-qt/Dockerfile))

The `*-no-qt` tags have no version of the Qt GUI libraries installed; those not so marked have Qt5 for (Debian) Stretch and Alpine, and Qt4 for (Debian) Jessie.

There are no "slim" images for Alpine, as the entire point of Alpine is *to be a* minimal base distribution.

# Software

## Debian Stretch or Jessie

### Base Software

The following Debian packages are installed in Debian-based images of this repo:

* `build-essential`
* `curl`
* `libpq-dev`
* `libxml2-dev`
* `libxslt1-dev`
* `nodejs`
* `postgresql-client`
* `sudo`
* `wget`
* `zsh`

### Qt5 Software (for Stretch)

The following Debian packages are installed in Stretch images not tagged `no-qt` of this repo. This is useful for test-mode builds that include tools such as [Capybara](https://github.com/teamcapybara/capybara):

* `libqtwebkit-dev`
* `xvfb`

### Qt4 Software (for Jessie)

The following Debian packages are installed in Jessie images not tagged `no-qt` of this repo. This is useful for test-mode builds that include tools such as [Capybara](https://github.com/teamcapybara/capybara):

* `libqt4-dev`
* `libqt4-webkit`
* `xvfb`

## Alpine Linux

### Base Software

The following Alpine packages are installed in Alpine-based images of this repo:

* `alpine-sdk`
* `bash`
* `build-base`
* `nodejs`
* `postgresql-client`
* `postgresql-dev`
* `tzdata`
* `zsh`

### Qt5 Software

The following Alpine packages are installed in Alpine images not tagged `no-qt` of this repo. This is useful for test-mode builds that include tools such as [Capybara](https://github.com/teamcapybara/capybara):

* `libxml2-dev`
* `libxslt-dev`
* `qt5-qtwebkit-dev`
* `xvfb`

# Additional Documentation

See the [official Ruby Docker image docs](https://hub.docker.com/_/ruby/).

# Legal

All files in this repository are Copyright &copy; 2017 by Jeff Dickey, and licensed under the [MIT License](https://opensource.org/licenses/MIT).

As with all Docker images, these likely also contain other software which may be under other licenses (such as Bash, etc from the base distribution, along with any direct or indirect dependencies of the primary software being contained).

As for any pre-built image usage, it is the image user's responsibility to ensure that any use of this image complies with any relevant licenses for all software contained within.
