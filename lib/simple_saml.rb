require "simple_saml/version"
require "simple_saml/configuration"

module SimpleSaml
  class << self
    attr_accessor :configuration
  end

  def self.configuration
    @configuration ||= SimpleSaml::Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end
