module SimpleSaml
  class Request
    require "onelogin/ruby-saml"

    def initialize(credentials)
      @request = OneLogin::RubySaml::Authrequest.new
      @settings = SimpleSaml::Settings.set(credentials)
    end

    def login_url
      @request.create(@settings)
    end
  end
end