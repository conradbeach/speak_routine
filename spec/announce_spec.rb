require_relative '../announce'

RSpec.describe Announce do
  before do
    allow(Announce).to receive(:system)
    allow(Announce).to receive(:puts)
  end

  let(:say_message) { "Testing" }
  let(:text_message) { "----Testing----" }

  describe ".announce" do
    context "when only say_message is given" do
      it "says the message" do
        described_class.announce(say_message)

        expect(described_class).to have_received(:system).with("say -v Samantha \"#{say_message}\"")
      end

      it "uses the say_message for the text_message" do
        described_class.announce("Testing")

        expect(described_class).to have_received(:puts).with(say_message)
      end
    end

    context "when a text message is given" do
      it "shows the text_message" do
        described_class.announce(say_message, text_message)

        expect(described_class).to have_received(:puts).with(text_message)
      end
    end
  end

  describe ".padded_announce" do
    it "adds blank lines around the text_message" do
      described_class.padded_announce(say_message, text_message)

      expect(described_class).to have_received(:puts).with("\n#{text_message}\n\n")
    end
  end

  describe ".announce_completion" do
    it "says the routine is completed" do
      described_class.announce_completion

      expect(described_class).to have_received(:system).with("say -v Samantha \"Routine Complete\"")
    end

    it "prints that the routine is completed" do
      described_class.announce_completion

      expect(described_class).to have_received(:puts).with(a_string_including("Routine Complete"))
    end
  end
end
