require "ostruct"

RSpec.describe SimpleSaml::AdminCredential do
  let(:request) { OpenStruct.new(base_url: "https://localhost:3000") }

  before(:each) { SimpleSaml::AdminCredential.reset_config }

  it "are nil when configs not set" do
    credentials = SimpleSaml::AdminCredential.new(request)

    expect(credentials.provider).to be nil
    expect(credentials.login_url).to be nil
    expect(credentials.cert_fingerprint).to be nil
    expect(credentials.name_identifier_format).to be nil
    expect(credentials.entity_id).to eq "https://localhost:3000"
    expect(credentials.callback_url).to eq "https://localhost:3000/auth/saml/callback"
  end

  it "are present when configs set" do
    set_configurations!
    credentials = SimpleSaml::AdminCredential.new(request)

    expect(credentials.provider).to eq :beddoes
    expect(credentials.login_url).to eq "https://auth.beddoes.com.au/login_url"
    expect(credentials.cert_fingerprint).to eq "AB:23:CH:54..."
    expect(credentials.name_identifier_format).to eq "urn:oasis:names..."
    expect(credentials.entity_id).to eq "https://localhost:3000"
    expect(credentials.callback_url).to eq "https://localhost:3000/auth/saml/callback"
  end
end
