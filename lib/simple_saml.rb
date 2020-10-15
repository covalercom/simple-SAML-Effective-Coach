require "simple_saml/version"
require "simple_saml/configuration"
require "simple_saml/admin_credential"
require "simple_saml/settings"
require "simple_saml/request"

module SimpleSaml
  class << self
    attr_accessor :configuration
  end

  def self.configuration
    @configuration ||= SimpleSaml::Configuration.new
  end

  def self.reset_config
    @configuration = SimpleSaml::Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end
