#!/usr/bin/env ruby
# frozen_string_literal: true

require 'yaml'
require 'docker'

data = YAML.load_file('builds.yml')
builds = data['data']['builds']
repo_name = 'jdickey/ruby'

builds.map do |version_id, version_data|
  version_data.map do |os_id, build_data|
    image_name = "#{repo_name}:#{version_id}-#{os_id}"
    image = Docker::Image.get(image_name)
    build_data['tags'].map { |tag| image.tag(repo: repo_name, tag: tag) }
    image.tag(repo: repo_name, tag: 'latest') if build_data['actual_latest']
  end
end
