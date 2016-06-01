require 'journey'

describe Journey do
  subject(:journey) { described_class.new(station1) }
  let(:station1) { double(:station1, name: "Vauxhall", zone: 2)}
  let(:station2) { double(:station2, name: "Aldgate", zone: 1)}

  describe '#new' do
    it 'starts the journey' do
      expect(journey.entry_station).to be station1
    end
  end

  describe '#end_journey' do
    it 'ends the journey' do
      journey.end_journey(station2)
      expect(journey.exit_station).to be station2
    end
  end

  describe '#complete?' do
    it 'has an incomplete journey' do
      expect(journey).to_not be_complete
    end

    it 'completes the journey' do
      journey.end_journey(station2)
      expect(journey).to be_complete
    end
  end

  describe '#fare' do
    it 'returns a penalty fare when no exit' do
      expect(journey.fare).to be(described_class::PENALTY_FARE)
    end
    it 'returns a minimum fare for complete journey' do
      journey.end_journey(station2)
      expect(journey.fare).to be(described_class::MINIMUM_FARE)
    end
  end
end
