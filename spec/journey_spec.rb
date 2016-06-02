require 'journey'

describe Journey do

  subject(:journey) { described_class.new(station) }

  let(:station) { double(:station) }
  let(:min_fare) { described_class::MINIMUM_FARE}

  it 'will be initialized with a new entry station' do
    expect(journey.entry_station).to eq(station)
  end
  
  describe '#set_exit' do
    it '#set_exit stores the exit station' do
      expect{journey.set_exit(station)}.to change{journey.exit_station}.to (station)
    end
  end

  describe '#fare' do
    it 'returns the minimum fare' do
      expect(journey.fare).to eq(min_fare)
    end
  end

  describe '#complete?' do
    it '' do
      
    end
  end

end
