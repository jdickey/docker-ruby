# frozen_string_literal: true

class DockerfileBuilder
  class Description
    def self.call(config)
      new(config).call
    end

    def call
      ret = "Base image for #{image_string}, with "
      return (ret + 'Qt and capybara-webkit') if config.qt?
      ret + 'NodeJS, but without Qt'
    end

    protected

    def initialize(config)
      @config = config.dup.freeze
    end

    private

    attr_reader :config

    def image_string
      config.base_image_spec
    end
  end # class DockerfileBuilder::Description

  class InitialEnv
    def initialize(lang: 'en', lc_all: 'C')
      @lang = lang
      @lc_all = lc_all
    end

    def to_str
      items = { lang: @lang, lc_all: @lc_all }

      items.map { |var, value| "ENV #{var.to_s.upcase} #{value}\n" }.join
    end
  end # class DockerfileBuilder::InitialEnv

  class Labels
    def self.call(config:)
      new(config).call
    end

    def call
      ret = [description, includes_qt, maintainer, version].join("\n") + "\n"
      ret.freeze
    end

    protected

    def initialize(config)
      @config = config
    end

    private

    attr_reader :config

    def description
      str = Description.call(config)
      %(LABEL description="#{str}")
    end

    def hanami_version
      %(LABEL hanami-version="#{config.hanami_version}")
    end

    def includes_hanami_model
      %(LABEL includes-hanami-model=#{config.hm?})
    end

    def includes_qt
      %(LABEL includesQt=#{config.qt?})
    end

    def maintainer
      %(LABEL maintainer="#{config.maintainer}")
    end

    def version
      %(LABEL version="#{config.image_version}")
    end
  end # class DockerfileBuilder::Labels

  class Commands
    def self.call(config:)
      new(config).call
    end

    def call
      ["RUN #{config.upgrade_cmd}", copy_gems].join("\n") + "\n"
    end

    protected

    def initialize(config)
      @config = config
    end

    private

    attr_reader :config

    def copy_gems
      hm = config.hm? ? "hm" : "no-hm"
      qt = config.qt? ? "qt" : "no-qt"
      filename = [GEM_BUILDER_PREFIX, hm, qt].join('.')
      commands = File.read(filename).lines
        .select { |line| line.match(/gem install /) }
        .map(&:rstrip).join(' && ')
      "RUN #{commands}"
    end

    GEM_BUILDER_PREFIX = './gem-scripts/install-gems'
    private_constant :GEM_BUILDER_PREFIX
  end # class DockerfileBuilder::Commands

  ###                                                                        ###
  ### DockerfileBuilder main class                                           ###
  ###                                                                        ###

  # MUST pass DockerfileBuilder::Config instance
  def self.call(config:)
    new(config: config).call
  end

  def call
    [from_image, initial_env, labels, commands].join("\n") + "\n"
  end

  protected

  def initialize(config:)
    @config = config
    self
  end

  private

  attr_reader :config

  def commands
    "RUN #{config.upgrade_cmd}\n"
  end

  def from_image
    "FROM ruby:#{config.base_image_spec}\n"
  end

  def initial_env
    InitialEnv.new.to_str
  end

  def labels
    Labels.call(config: config)
  end
end # class DockerfileBuilder
