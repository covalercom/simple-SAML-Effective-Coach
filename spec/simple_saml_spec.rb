RSpec.describe SimpleSaml do
  before(:each) { SimpleSaml.reset_config }

  it "has a version number" do
    expect(SimpleSaml::VERSION).not_to be nil
  end

  it "configs are nil by default" do
    config = SimpleSaml.configuration

    expect(config.provider).to be nil
    expect(config.login_url).to be nil
    expect(config.cert_fingerprint).to be nil
    expect(config.name_identifier_format).to be nil
  end

  it "can be configured" do
    set_configurations!
    config = SimpleSaml.configuration

    expect(config.provider).to eq(:beddoes)
    expect(config.login_url).to eq("https://localhost:3000/login")
    expect(config.cert_fingerprint).to eq("AB:23:CH:54...")
    expect(config.name_identifier_format).to eq("urn:oasis:names...")
  end
end
