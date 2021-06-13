# frozen_string_literal: true

module AccountsSession
  module Decoders
    module JwtToken
      def self.decode(token)
        JWT.decode(
          token,
          AccountsSession.configuration.jwt_token_secret,
          true,
          { algorithm: "HS256" }
        ).first
      end
    end
  end
end
