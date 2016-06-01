require 'journey_log'

describe JourneyLog do
  subject(:journey_log) { described_class.new(journey_class: journey_class) }
  let(:journey_class) { double(:journey_class, new: journey) }
  let(:journey) { double(:journey, end_journey: nil) }
  let(:station1) { double(:station1) }
  let(:station2) { double(:station2) }

  describe '#start' do
    it 'creates a new journey' do
      expect(journey_class).to receive(:new)
      journey_log.start(station1)
    end
  end

  describe '#current_journey' do
    it 'return a journey object' do
      journey_log.start(station1)
      expect(journey_log.current_journey).to eq journey
    end
  end

  describe "#finish" do
    it "should add an exit station to the current journey" do
      journey_log.start(station1)
      expect(journey).to receive(:end_journey)
      journey_log.finish(station2)
    end

  end

end
