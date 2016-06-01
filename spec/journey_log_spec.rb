require 'journey_log'

describe JourneyLog do
  subject(:journey_log) { described_class.new(journey_class: journey_class) }
  let(:journey_class) { double(:journey_class, new: journey) }
  let(:journey) { double(:journey, end_journey: nil, complete?: true) }
  let(:station1) { double(:station1) }
  let(:station2) { double(:station2) }

  describe '#start' do
    it 'creates a new journey' do
      expect(journey_class).to receive(:new)
      journey_log.start(station1)
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
