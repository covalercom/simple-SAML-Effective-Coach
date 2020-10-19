# SimpleSaml

SimpleSaml provides an easy interface for the *Service Provider* in a SAML authentication flow.

It is built on top of the `ruby-saml` gem and further simplifies creating SAML requests & responses, and also maps response attributes.

It also includes an `AdminCredential` module which can be configured once for multiple instances. This means admins of a system can use
the `AdminCredential` to initiate SAML authentication, whereas non-admins (customers) can have a unique SAML credential on each instance.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'simple_saml'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install simple_saml

## Usage

Create an initializer to set up admin credentials. These are used for Allori / Beddoes admin authentication only:

```ruby
# e.g. config/initializers/simple_saml.rb in a Rails app
SimpleSaml::AdminCredential.configure do |config|
  config.provider = :beddoes
  config.name_identifier_format = "urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress"
  config.callback_path = "/auth/saml/admin/callback" # optional, defaults to "/auth/saml/callback"

  if Rails.env.production?
    config.login_url = "https://auth.beddoes.com.au/login/url/path"
    config.cert_fingerprint = "AB:23:CH:54..."
  else
    config.login_url = "https://localhost:3100/login/url/path"
    config.cert_fingerprint = "CD:12:AB:3F..."
  end
end
```

Then in a controller:

```ruby
# Beddoes admin credentials
def new
  credentials = SimpleSaml::AdminCredential.new(request)
  request = SimpleSaml::Request.new(credentials)
  redirect_to request.login_url
end

def create
  credentials = SimpleSaml::AdminCredential.new(request)
  response = SimpleSaml::Response.new(params[:SAMLResponse], credentials)

  if response.valid?
    attributes = response.mapped_attributes
    user = User.find_by_email(attributes[:email])
    # sign in user etc.
    # refer lib/simple_saml/response.rb for available attributes
  else
    # display errors
    # errors array can be accessed via `response.errors`
  end
end
```

For admin credentials the `entity_id` and `callback_url` are set dynamically based on the `request.base_url`.

For example, if called from `https://auth.beddoes.com.au` the `entity_id` will be `https://auth.beddoes.com.au` and
the `callback_url` will be `https://auth.beddoes.com.au/auth/saml/callback`.

Paste these values in Azure SAML app config, the first for the `Identifier (Entity ID)` and the second for `Reply URL (Assertion Consumer Service URL)`.

For clients the credential object can be retrieved from the database instead and all fields including `entity_id` and `callback_url` should be hard coded:

```ruby
# Non-Beddoes client credentials
def new
  credentials = YourModel.find_by_foo(params[:foo])
  request = SimpleSaml::Request.new(credentials)
  # ...
end
```

Required fields can be found in `lib/simple_saml/settings.rb`.

## Cert fingerprint

To generate a certificate fingerprint for the `cert_fingerprint` field run the following command:

```
openssl x509 -in development.crt -noout -fingerprint -sha256
# SHA256 Fingerprint=5C:68:18:82:48:38:73:9D:44:31:5F:69...
```

## Creating mapping for additional Identity Providers

To add additional attribute mappings edit the `MAPPING` constant in `lib/simple_saml/response.rb`.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.