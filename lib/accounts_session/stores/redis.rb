# frozen_string_literal: true

module AccountsSession
  module Stores
    module Redis
      def self.exists?(session_id:)
        AccountsSession.configuration.redis_instance.exists?(
          "#{AccountsSession.configuration.session_key_prefix}#{session_id}"
        )
      end
    end
  end
end
