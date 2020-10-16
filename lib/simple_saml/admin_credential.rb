module SimpleSaml
  class AdminCredential
    class << self
      attr_accessor :configuration
    end

    attr_reader :provider, :entity_id, :callback_url, :callback_path
    attr_reader :login_url, :cert_fingerprint, :name_identifier_format

    def initialize(request)
      @provider = config.provider
      @login_url = config.login_url
      @cert_fingerprint = config.cert_fingerprint
      @name_identifier_format = config.name_identifier_format
      @callback_path = config.callback_path || "/auth/saml/callback"
      @entity_id = set_entity_id(request)
      @callback_url = set_callback_url(request)
    end

    def config
      @config ||= SimpleSaml::AdminCredential.configuration
    end

    def set_entity_id(request)
      request.base_url
    end

    def set_callback_url(request)
      set_entity_id(request) + callback_path
    end

    def self.configuration
      @configuration ||= SimpleSaml::AdminConfiguration.new
    end

    def self.reset_config!
      @configuration = SimpleSaml::AdminConfiguration.new
    end

    def self.configure
      yield(configuration)
    end
  end
end