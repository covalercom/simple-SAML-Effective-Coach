RSpec.describe SimpleSaml::Request do
  let(:request) { OpenStruct.new(base_url: "https://localhost:3000") }

  before(:all) { set_configurations! }

  it "creates valid SAML request login URL" do
    credentials = SimpleSaml::AdminCredential.new(request)
    request = SimpleSaml::Request.new(credentials)

    expect(request.login_url).to start_with "https://auth.beddoes.com.au/login_url?SAMLRequest="
  end
end
