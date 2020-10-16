RSpec.describe SimpleSaml::Response do
  let(:request) { OpenStruct.new(base_url: "https://localhost:3000") }

  before(:all) { set_configurations! }

  it "creates response object" do
    credentials = SimpleSaml::AdminCredential.new(request)
    response = SimpleSaml::Response.new(invalid_params, credentials)

    expect(response.valid?).to be false
    expect(response.xml).to start_with "<samlp:Response ID="
    expect(response.attributes["email"]).to eq ["daniel@beddoes.com.au"]
    expect(response.attributes["name"]).to eq ["Daniel Wachtel"]
  end
end
