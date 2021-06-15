# frozen_string_literal: true

module AccountsSession
  module Encoders
    module JwtToken
      def self.encode(session)
        JWT.encode(
          {
            session_id: session.session_id,
            account: session.account_hash
          },
          AccountsSession.configuration.jwt_token_secret,
          "HS256"
        )
      end
    end
  end
end
