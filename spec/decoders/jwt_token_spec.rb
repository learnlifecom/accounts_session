# frozen_string_literal: true

RSpec.describe AccountsSession::Decoders::JwtToken do
  let(:session) do
    AccountsSession::Session.new(
      session_id: "session_id",
      uuid: "uuid",
      first_name: "John",
      last_name: "Doe",
      email: "john@doe.com",
      avatar_url: "http://img.com"
    )
  end

  let(:jwt_token) { AccountsSession::Encoders::JwtToken.encode(session) }

  subject do
    described_class.decode(jwt_token)
  end


  describe ".decode" do
    it "parses generated jwt token" do
      expect(subject).to eq(
        "session_id" => "session_id",
        "account" => {
          "uuid" => "uuid",
          "first_name" => "John",
          "last_name" => "Doe",
          "email" => "john@doe.com",
          "avatar_url" => "http://img.com",
        }
      )
    end
  end
end
