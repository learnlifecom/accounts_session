# frozen_string_literal: true

module AccountsSession
  class Configuration
    attr_accessor :redis_instance, :jwt_token_secret, :session_key_prefix
  end
end
