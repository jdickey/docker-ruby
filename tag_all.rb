#!/usr/bin/env ruby
# frozen_string_literal: true

require 'ostruct'
require 'yaml'
require 'docker'
require_relative './build-image'
require_relative './build_image_list'

images = BuildImageList.call(yaml_file: './builds.yml');

images.each do |image_name, image_list_item|
  repo_name = 'jdickey/ruby'
  full_name = [repo_name, image_name].join(':')
  image = Docker::Image.get(full_name)
  image_list_item.tags.map { |tag| image.tag repo: repo_name, tag: tag }
  image.tag(repo: repo_name, tag: 'latest') if image_list_item.latest?
end
