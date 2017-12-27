require 'simplecov'

# Save to CircleCI's artifacts directory if we're on CircleCI
if ENV['CIRCLE_ARTIFACTS']
  dir = File.join(ENV['CIRCLE_ARTIFACTS'], "coverage")
  SimpleCov.coverage_dir(dir)
end

SimpleCov.start

require "bundler/setup"
require "clover"

require 'rspec/its'
require 'webmock/rspec'

CLOVER_BASE_URI = 'https://apisandbox.dev.clover.com'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  Dir['spec/support/**/*'].each do |f|
    load f
  end

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
