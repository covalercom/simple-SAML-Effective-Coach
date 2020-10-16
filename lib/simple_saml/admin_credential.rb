module SimpleSaml
  class AdminCredential
    class << self
      attr_accessor :configuration
    end

    attr_reader :provider, :entity_id, :callback_url, :login_url, :cert_fingerprint, :name_identifier_format

    def initialize(request)
      @provider = config.provider
      @entity_id = set_entity_id(request)
      @callback_url = set_callback_url(request)
      @login_url = config.login_url
      @cert_fingerprint = config.cert_fingerprint
      @name_identifier_format = config.name_identifier_format
    end

    def config
      @config ||= SimpleSaml::AdminCredential.configuration
    end

    def set_entity_id(request)
      request.base_url
    end

    def set_callback_url(request)
      set_entity_id(request) + "/auth/saml/callback"
    end

    def self.configuration
      @configuration ||= SimpleSaml::AdminConfiguration.new
    end

    def self.reset_config
      @configuration = SimpleSaml::AdminConfiguration.new
    end

    def self.configure
      yield(configuration)
    end
  end
end