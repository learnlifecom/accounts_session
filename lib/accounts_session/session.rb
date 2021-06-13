# frozen_string_literal: true

module AccountsSession
  Session = Struct.new(
    :session_id,
    :first_name,
    :last_name,
    :email,
    :uuid,
    :avatar_url,
    keyword_init: true
  ) do

    def to_jwt
      AccountsSession::Encoders::JwtToken.encode(self)
    end

    def authenticated?
      AccountsSession::Stores::Redis.exists?(session_id: session_id)
    end

    def account_hash
      to_h.slice(:first_name, :last_name, :email, :uuid, :avatar_url)
    end
  end
end
