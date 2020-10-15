module HelperMethods
  def set_configurations!
    SimpleSaml.configure do |config|
      config.provider = :beddoes
      config.login_url = "https://localhost:3000/login"
      config.cert_fingerprint = "AB:23:CH:54..."
      config.name_identifier_format = "urn:oasis:names..."
    end
  end
end