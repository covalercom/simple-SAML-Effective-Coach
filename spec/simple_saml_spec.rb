RSpec.describe SimpleSaml do
  it "has a version number" do
    expect(SimpleSaml::VERSION).not_to be nil
  end

  it "can be configured" do
    SimpleSaml.configure do |config|
      config.provider = :beddoes
      config.login_url = "https://localhost:3000/login"
      config.cert_fingerprint = "AB:23:CH:54..."
      config.name_identifier_format = "urn:oasis:names..."
    end

    config = SimpleSaml.configuration
    expect(config.provider).to eq(:beddoes)
    expect(config.login_url).to eq("https://localhost:3000/login")
    expect(config.cert_fingerprint).to eq("AB:23:CH:54...")
    expect(config.name_identifier_format).to eq("urn:oasis:names...")
  end
end
