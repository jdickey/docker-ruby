# frozen_string_literal: true

require 'yaml'

require_relative './image_item'

class BuildImageList
  def self.call(yaml_file:)
    new(yaml_file).call
  end

  def call
    ret = {}
    builds.map do |ruby_version, per_version|
      per_version.map do |base_os, per_base_os|
        per_base_os.map do |qt_key, per_qt|
          params = {
            base_os: base_os,
            image_version: image_version,
            qt: qt_key.to_s,
            ruby_version: ruby_version,
            tags: per_qt['tags'],
            latest: per_qt['actual_latest'] || false
          }
          item = ImageItem.new params
          ret[item.build_tag_name] = item.freeze
        end # per_base_os.map
      end # per_version.map
    end # builds.map
    ret
  end

  protected

  def initialize(yaml_file)
    image_config_data = YAML.load_file(yaml_file)
    @builds = image_config_data['builds']
    @hanami_version =image_config_data['metadata']['hanami_version']
    @hanami_model_version =image_config_data['metadata']['hanami_model_version']
    @image_version = image_config_data['metadata']['image_version']
  end

  private

  attr_reader :builds, :hanami_model_version, :hanami_version, :image_version
end # class BuildImageList
