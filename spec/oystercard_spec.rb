require "oystercard"

describe Oystercard do

  subject(:oystercard) { described_class.new(journey_log) }
  let(:journey) { double(:journey, fare: 1) }
  let(:journey_log) { double(:journey_log, start: nil, current_journey: journey, finish: nil) }

  let(:station) { double(:station, zone: 1) }
  let(:station2) { double(:station2, zone: 1) }

  describe "#balance" do
    it "doesn't return nil" do
      expect(oystercard.balance).to_not be(nil)
    end
  end

  describe "#top_up" do
    it "takes a number" do
      expect { oystercard.top_up(10) }.to change { oystercard.balance }.by(10)
    end

    it "won't accept a topup over the limit" do
      max = Oystercard::MAXIMUM_LIMIT
      expect { oystercard.top_up(max + 1) }.to raise_error
    end
  end

  describe "#touch_in" do
    before do
      oystercard.top_up(Oystercard::MINIMUM_FARE)
    end

    it "begins the journey" do
      expect(journey_log).to receive(:start).with(station)
      oystercard.touch_in(station)
    end

    context "low balance" do
      subject(:oystercard_low_balance) { described_class.new }

      it "throws an error if balance is too low" do
        expect { oystercard_low_balance.touch_in }.to raise_error
      end
    end
  end

  describe "#touch_out" do
    before do
      oystercard.top_up(10)
      oystercard.touch_in(station)
    end

    it "sends #finish to journey_log" do
      expect(journey_log).to receive(:finish).with(station2)
      oystercard.touch_out(station2)
    end

    it "deducts the minimum fare" do
      expect { oystercard.touch_out(station2) }.to change { oystercard.balance }.by(-Oystercard::MINIMUM_FARE)
    end
  end

end
