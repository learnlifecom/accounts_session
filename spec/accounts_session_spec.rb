# frozen_string_literal: true

RSpec.describe AccountsSession do
  it "has a version number" do
    expect(AccountsSession::VERSION).not_to be nil
  end

  context "configuration" do
    describe ".configure" do
      it "configures jwt_token_secret" do
        expect(AccountsSession.configuration.jwt_token_secret).to eq("secret")
      end

      it "configures redis_instance" do
        expect(AccountsSession.configuration.redis_instance).to be_a(Redis)
      end

      it "configures session_key_prefix" do
        expect(AccountsSession.configuration.session_key_prefix).to eq("accounts:session:")
      end
    end

    describe ".reset" do
      before do
        AccountsSession.reset
      end

      it "cleanup configuration" do
        expect(AccountsSession.configuration.jwt_token_secret).to be_nil
        expect(AccountsSession.configuration.redis_instance).to be_nil
        expect(AccountsSession.configuration.session_key_prefix).to be_nil
      end
    end
  end


  describe ".build" do
    subject do
      described_class.build(
        session_id: "session_id",
        uuid: "uuid",
        first_name: "John",
        last_name: "Doe",
        email: "john@doe.com",
        avatar_url: "http://img.com"
      )
    end

    it "builds session object" do
      expect(subject).to be_a(AccountsSession::Session)
    end

    it "fills all attributes" do
      expect(subject.session_id).to eq("session_id")
      expect(subject.uuid).to eq("uuid")
      expect(subject.first_name).to eq("John")
      expect(subject.last_name).to eq("Doe")
      expect(subject.email).to eq("john@doe.com")
      expect(subject.avatar_url).to eq("http://img.com")
    end
  end

  describe ".from_token" do
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
      described_class.from_token(jwt_token)
    end

    it "builds session object" do
      expect(subject).to be_a(AccountsSession::Session)
    end

    it "fills all attributes" do
      expect(subject.session_id).to eq("session_id")
      expect(subject.uuid).to eq("uuid")
      expect(subject.first_name).to eq("John")
      expect(subject.last_name).to eq("Doe")
      expect(subject.email).to eq("john@doe.com")
      expect(subject.avatar_url).to eq("http://img.com")
    end
  end
end
