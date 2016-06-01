require 'journey_log'

describe JourneyLog do
  subject(:journey_log) { described_class.new(journey_class: journey_class) }
  let(:journey_class) { double(:journey_class, new: journey) }
  let(:station1) { double(:station1) }
  let(:journey) { double(:journey) }

  describe '#start' do
    it 'adds a journey to the log' do
      expect { journey_log.start(station1) }.to change { journey_log.journeys.count }.by(1)
    end
  end

  describe '#current_journey' do
    it 'return a journey object' do
      journey_log.start(station1)
      expect(journey_log.current_journey).to eq journey
    end
  end
end
