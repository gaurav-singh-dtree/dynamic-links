require "active_support/dependencies"
require "dynamic_links/engine"
require "dynamic_links/config"

module DynamicLinks
  class << self
    attr_accessor :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.reset
    @configuration = Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end
