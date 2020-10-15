module SimpleSaml
  class Configuration
    attr_accessor :login_url, :cert_fingerprint, :name_identifier_format

    def initialize
      @login_url = nil
      @cert_fingerprint = nil
      @name_identifier_format = nil
    end
  end
end