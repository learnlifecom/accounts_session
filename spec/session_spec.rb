# frozen_string_literal: true

RSpec.describe AccountsSession::Session do
  subject do
    described_class.new(
      session_id: "session_id",
      uuid: "uuid",
      first_name: "John",
      last_name: "Doe",
      email: "john@doe.com",
      avatar_url: "http://img.com"
    )
  end

  describe ".to_jwt" do
    it "generate valid jwt token" do
      expect(subject.to_jwt).to include("eyJhbGciOiJIUzI1NiJ9.eyJzZXNzaW9uX2lkIjoic2Vzc2lvbl9pZCIsImF")
    end
  end

  describe ".authenticated?" do
    before do
      allow(AccountsSession::Stores::Redis).to receive(:exists?).with(session_id: "session_id") { key_exists }
    end

    context "when session key exists in store" do
      let(:key_exists) { true }

      it "is truthy" do
        expect(subject).to be_authenticated
      end
    end

    context "when session key doesn't exists in store" do
      let(:key_exists) { false }

      it "is falsy" do
        expect(subject).not_to be_authenticated
      end
    end
  end

  describe ".account_hash" do
    it "slice account attributes" do
      expect(subject.account_hash).to eq({
        uuid: "uuid",
        first_name: "John",
        last_name: "Doe",
        email: "john@doe.com",
        avatar_url: "http://img.com"
      })
    end
  end
end
