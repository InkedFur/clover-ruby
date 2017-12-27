# Clover
[![CircleCI](https://circleci.com/gh/InkedFur/clover-ruby/tree/master.svg?style=svg)](https://circleci.com/gh/InkedFur/clover-ruby/tree/master)

Work in progress! This gem provides a handy ORM-like wrapper for the Clover API.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'clover-ruby'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install clover-ruby

## Usage

First, configure (if Rails, add this to `config/initializers/clover.rb`):

```ruby
Clover.configure do |config|
  # Required unless initializing via OAuth flow:
  config.merchant_id = "<Clover Merchant ID>"
  config.api_token = "<API Token from OAuth>" 

  # Optional, required if using prod ENV:
  config.api_endpoint = 'https://api.clover.com/v3'
  
  # Optional, required if using OAuth helpers:
  config.client_secret = "<Your App Secret>"
  config.client_id = "<Your App ID>"
  config.oauth_authorize_url = 'https://api.clover.com'
  config.oauth_redirect_url = 'https://yourapp.com/oauth/callback'
end
```

If you don't want to specify a config block, Clover will default
to using your ENV variables. The names are the same, with
`CLOVER_` prepended to them. You should check out the `dot-env` gem!

```ruby
ENV['CLOVER_CLIENT_ID'] = 'foobar'

Clover.configuration.client_id #=> 'foobar'
```

Then, change your Merchant name:

```ruby
merchant = Clover::Merchant.find "<merchant id>"
merchant.name = 'Some Cool Name'
merchant.save
```

Assuming you configured with a `merchant_id`, get your items.

```ruby
merchant = Clover::Merchant.current
merchant.items #=> [ #<Clover::Item id=1...> ]
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/William Eisert/clover-ruby. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

