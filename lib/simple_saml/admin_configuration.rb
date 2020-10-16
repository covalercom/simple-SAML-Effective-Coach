module SimpleSaml
  class AdminConfiguration
    attr_accessor :provider, :login_url, :cert_fingerprint, :name_identifier_format, :callback_path

    def initialize
      @provider = nil
      @login_url = nil
      @cert_fingerprint = nil
      @name_identifier_format = nil
      @callback_path = nil
    end
  end
end