[![Build Status](https://secure.travis-ci.org/clowder/encrypted-attributes.png)](http://travis-ci.org/clowder/encrypted-attributes)

# EncryptedAttributes

## Usage

Encrypt your columns like so:

```ruby
class Deployment < ActiveRecord::Base
  extend EncryptedAttributes
  
  serialize :secret_config, Hash
  encrypt :secret_config
end
```

### Rails 3.x

Here is an example config/encryption_keys.yml file:

```yaml
common: &shared
# Digest::SHA2.hexdigest('Bond, James Bond')
  key: 989e6405af5c637850f1e97861eb42d326f4b416b91ad37b2e573ed045cc1cf5
# SecureRandom.urlsafe_base64(4)
  iv: C4vaiQ

development:
  <<: *shared  

test:
  <<: *shared

production:   # DO NOT CHECK THIS IN TO VCS! uplaod it to the production server directly
  key:
  iv:

```

### Rails 2.3.x

Add something like this to config/initializers/encrypted_attributes.yml:

```ruby
path      = Rails.root.join( Rails.root, 'config', 'encryption_keys.yml' )
ae_config = File.exist?(path) ? YAML.load( File.open(path) )[ Rails.env ] : {}
ae_config['key'] ||= ENV['ENCRYPTED_ATTRIBUTES_KEY']
ae_config['iv']  ||= ENV['ENCRYPTED_ATTRIBUTES_IV']

EncryptedAttributes.setup( ae_config.extract! 'key', 'iv' )
```



## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
