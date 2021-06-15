# frozen_string_literal: true

RSpec.describe AccountsSession::Stores::Redis do

  describe ".exists?" do
    context "when session key exists in store" do
      before do
        Redis.current.set("accounts:session:session_key", "1")
      end

      it "is truthy" do
        expect(subject.exists?(session_id: "session_key")).to be_truthy
      end
    end

    context "when session key doesn't exists in store" do
      before do
        Redis.current.del("accounts:session:session_key")
      end

      it "is falsy" do
        expect(subject.exists?(session_id: "session_key")).to be_falsy
      end
    end
  end
end
