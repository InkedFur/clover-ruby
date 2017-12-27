module Clover
  class << self
    attr_writer :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield configuration
  end
end

# Dependencies
require 'her'

# Local
require 'clover/version'
require 'clover/configuration'
require 'clover/authentication'
require 'clover/remote_base'

# Models
require 'clover/merchant'
