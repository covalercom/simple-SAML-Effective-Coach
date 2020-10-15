module SimpleSaml
  module Settings
    extend self
    require "onelogin/ruby-saml"

    def set(credentials)
      settings = OneLogin::RubySaml::Settings.new

      settings.assertion_consumer_service_url = credentials.callback_url
      settings.sp_entity_id                   = credentials.entity_id
      settings.idp_sso_target_url             = credentials.login_url
      settings.idp_cert_fingerprint           = credentials.cert_fingerprint
      settings.name_identifier_format         = credentials.name_identifier_format
      settings.idp_cert_fingerprint_algorithm = "http://www.w3.org/2000/09/xmldsig#sha256"

      settings
    end
  end
end