RSpec.describe SimpleSaml::Response do
  let(:request) { OpenStruct.new(base_url: "https://localhost:3000") }
  let(:errors) { ["Invalid Audience. The audience https://lvh.me:3000, did not match the expected audience https://localhost:3000/auth/saml"] }

  before(:all) { set_configurations! }

  it "creates response object" do
    credentials = SimpleSaml::AdminCredential.new(request)
    response = SimpleSaml::Response.new(invalid_params, credentials)

    expect(response.valid?).to be false
    expect(response.errors).to eq errors
    expect(response.xml).to start_with "<samlp:Response ID="
    expect(response.attributes["email"]).to eq ["daniel@beddoes.com.au"]
    expect(response.attributes["name"]).to eq ["Daniel Wachtel"]
  end
end
