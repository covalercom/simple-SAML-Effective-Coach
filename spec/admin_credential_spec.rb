require "ostruct"

RSpec.describe SimpleSaml::AdminCredential do
  let(:request) { OpenStruct.new(base_url: "https://localhost:3000") }

  before(:each) { SimpleSaml.reset_config }

  it "are nil when configs not set" do
    credentials = SimpleSaml::AdminCredential.new(request)

    expect(credentials.provider).to be nil
    expect(credentials.login_url).to be nil
    expect(credentials.cert_fingerprint).to be nil
    expect(credentials.name_identifier_format).to be nil
    expect(credentials.entity_id).to eq "https://localhost:3000/auth/saml"
    expect(credentials.callback_url).to eq "https://localhost:3000/auth/saml/callback"
  end

  it "are present when configs set" do
    SimpleSaml.configure do |config|
      config.provider = :beddoes
      config.login_url = "https://localhost:3000/login"
      config.cert_fingerprint = "AB:23:CH:54..."
      config.name_identifier_format = "urn:oasis:names..."
    end

    credentials = SimpleSaml::AdminCredential.new(request)

    expect(credentials.provider).to eq :beddoes
    expect(credentials.login_url).to eq "https://localhost:3000/login"
    expect(credentials.cert_fingerprint).to eq "AB:23:CH:54..."
    expect(credentials.name_identifier_format).to eq "urn:oasis:names..."
    expect(credentials.entity_id).to eq "https://localhost:3000/auth/saml"
    expect(credentials.callback_url).to eq "https://localhost:3000/auth/saml/callback"
  end
end