module SimpleSaml
  class Response
    require "onelogin/ruby-saml"

    SAML_CLAIMS = "http://schemas.xmlsoap.org/ws/2005/05/identity/claims"
    AZURE_CLAIMS = "http://schemas.microsoft.com/identity/claims"

    MAPPING = {
      azure: {
        tenant_id: "#{AZURE_CLAIMS}/tenantid",
        uid: "#{AZURE_CLAIMS}/objectidentifier",
        name: "#{AZURE_CLAIMS}/displayname",
        first_name: "#{SAML_CLAIMS}/givenname",
        last_name: "#{SAML_CLAIMS}/surname",
        email: "#{SAML_CLAIMS}/emailaddress",
        title: "#{SAML_CLAIMS}/jobtitle"
      },
      beddoes: {
        tenant_id: "tenant_id",
        uid: "uid",
        name: "name",
        first_name: "first_name",
        last_name: "last_name",
        email: "email",
        title: "title"
      }
    }

    def initialize(params, credentials)
      @response = OneLogin::RubySaml::Response.new(params)
      @response.settings = SimpleSaml::Settings.set(credentials)
      @provider = credentials.provider.to_sym
    end

    def xml
      @response.response
    end

    def valid?
      @response.is_valid?
    end

    def errors
      @response.errors
    end

    def attributes
      @response&.attributes&.attributes || {}
    end

    def mapped_attributes
      MAPPING[@provider].inject({}) do |hash, (key, value)|
        hash[key] = attributes[value].try(:first); hash
      end
    end
  end
end