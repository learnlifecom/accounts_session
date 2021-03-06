# frozen_string_literal: true

require "bundler/setup"
require "accounts_session"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before(:each) do
    AccountsSession.configure do |config|
      config.jwt_token_secret = "secret"
      config.redis_instance = Redis.new
      config.session_key_prefix = "accounts:session:"
    end
  end

  config.after(:each) do
    AccountsSession.reset
  end

end
