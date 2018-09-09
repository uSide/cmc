ENV.store('APP_ENV', 'test')
require_relative 'fixture'
require_relative '../config/environment'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.before(:example) do
    Pull.truncate
    Currency.truncate(cascade: true)
  end
end
