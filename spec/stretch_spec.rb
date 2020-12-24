require_relative '../stretch'

RSpec.describe Stretch do
  describe "#duration" do
    context "when Stretch is initialized with a duration" do
      let(:duration) { 20 }
      let(:stretch) { Stretch.new(name: "Some Stretch", duration: duration) }

      it "returns that duration" do
        expect(stretch.duration).to eq(duration)
      end
    end

    context "when Stretch is not initialized with a duration" do
      let(:stretch) { Stretch.new(name: "Some Stretch") }

      it "returns that default duration" do
        expect(stretch.duration).to eq(Stretch::DEFAULT_DURATION)
      end
    end
  end

  describe "#duration_with_say" do
    let(:say_duration) { 2.2 }
    let(:stretch) { Stretch.new(name: "Some Stretch") }

    before do
      allow(Announce).to receive(:say_duration).and_return(say_duration)
    end

    it "returns the duration of the stretch along with how long the name takes to say" do
      expect(stretch.duration_with_say).to eq(Stretch::DEFAULT_DURATION + say_duration)
    end
  end
end
