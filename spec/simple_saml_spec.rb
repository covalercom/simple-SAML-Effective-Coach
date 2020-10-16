RSpec.describe SimpleSaml do
  before(:each) { SimpleSaml::AdminCredential.reset_config! }

  it "has a version number" do
    expect(SimpleSaml::VERSION).not_to be nil
  end
end
