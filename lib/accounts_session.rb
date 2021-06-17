# frozen_string_literal: true

require "redis"
require "jwt"
require "accounts_session/version"
require "accounts_session/configuration"
require "accounts_session/session"
require "accounts_session/stores/redis"
require "accounts_session/encoders/jwt_token"
require "accounts_session/decoders/jwt_token"

module AccountsSession
  class Error < StandardError; end

  NULL_SESSION = Session.new

  class << self
    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield(configuration)
    end

    def reset
      @configuration = Configuration.new
    end

    def build(session_atrrs)
      Session.new(**session_atrrs)
    end

    def from_token(token)
      return NULL_SESSION if token.nil?

      decoded = AccountsSession::Decoders::JwtToken.decode(token)
      flattened = decoded.merge(decoded.fetch("account"))

      build(
        flattened.slice(
          "session_id",
          "first_name",
          "last_name",
          "email",
          "uuid",
          "avatar_url"
        )
      )
    end
  end
end
