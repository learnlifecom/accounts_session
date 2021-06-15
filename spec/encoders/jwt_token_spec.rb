# frozen_string_literal: true

RSpec.describe AccountsSession::Encoders::JwtToken do
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

  subject do
    described_class.encode(session)
  end


  describe ".encode" do
    it "generate valid jwt token" do
      expect(subject).to include("eyJhbGciOiJIUzI1NiJ9.eyJzZXNzaW9uX2lkIjoic2Vzc2lvbl9pZCIsImF")
    end
  end
end
