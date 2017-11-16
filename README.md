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

This repo offers four variations on (presently) a single Ruby version:

* `2.4.2-jessie`, `2.4-jessie` `2-jessie`, `jessie`, `2.4.2`, `2.4`, `2`, and `latest` are all built from [this `Dockerfile`](https://github.com/jdickey/docker-ruby/2.4/jessie/Dockerfile). It is built from the official `ruby:2.4.2-jessie` build, with both the below [base software](#base-software) and [Qt4 software](#qt4-software) installed, as well as the current version of Bundler at the time the image was built (presently 1.16.0);
* `2.4.2-jessie-no-qt`, `2.4-jessie-no-qt`, `2-jessie-no-qt`, `jessie-no-qt`, `2.4.2-no-qt`, `2.4-no-qt`, `2-no-qt`, and `no-qt` are all built from [this `Dockerfile`](https://github.com/jdickey/docker-ruby/2.4/jessie/no-qt/Dockerfile). It is built from the official `ruby:2.4.2-jessie` build, with the [base software](#base-software) installed **but not** the [Qt4 software](#qt4-software). The current version of Bundler is also installed;
* `2.4.2-jessie-slim`, `2.4-jessie-slim` `2-jessie-slim`, `jessie-slim`, `2.4.2-slim`, `2.4-slim`, `2-slim`, and `slim` are all built from [this `Dockerfile`](https://github.com/jdickey/docker-ruby/2.4/jessie/slim/Dockerfile). It is built from the official `ruby:2.4.2-jessie-slim` build, with both the below [base software](#base-software) and [Qt4 software](#qt4-software) installed, as well as the current version of Bundler at the time the image was built (presently 1.16.0);
* `2.4.2-jessie-slim-no-qt`, `2.4-jessie-slim-no-qt`, `2-jessie-slim-no-qt`, `jessie-slim-no-qt`, `2.4.2-slim-no-qt`, `2.4-slim-no-qt`, `2-slim-no-qt`, and `slim-no-qt` are all built from [this `Dockerfile`](https://github.com/jdickey/docker-ruby/2.4/jessie/slim/no-qt/Dockerfile). It is built from the official `ruby:2.4.2-jessie` build, with the [base software](#base-software) installed **but not** the [Qt4 software](#qt4-software). The current version of Bundler is also installed.

Yes, that's 32 tags for 4 images. 😩

# Software

## Base Software

The following Debian packages are installed in all images of this repo:

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

## Qt4 Software

The following Debian packages are installed in all images not tagged `no-qt` of this repo. This is useful for test-mode builds that include tools such as [Capybara](https://github.com/teamcapybara/capybara):

* `libqt4-dev`
* `libqt4-webkit`
* `xvfb`


# Additional Documentation

See the [official Ruby Docker image docs](https://hub.docker.com/_/ruby/).

# Legal

All files in this repository are Copyright &copy; 2017 by Jeff Dickey, and licensed under the [MIT License](https://opensource.org/licenses/MIT).

As with all Docker images, these likely also contain other software which may be under other licenses (such as Bash, etc from the base distribution, along with any direct or indirect dependencies of the primary software being contained).

As for any pre-built image usage, it is the image user's responsibility to ensure that any use of this image complies with any relevant licenses for all software contained within.
