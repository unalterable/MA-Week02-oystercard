require 'journey'

describe Journey do

  subject(:journey) { described_class.new("Bank",station) }

  let(:station) { double(:station) }

  it 'will be initialized with a new entry station' do
    expect(journey.entry_station).to eq(station)
  end

  it '#set_exit stores the exit station' do
    expect{journey.set_exit("Poplar",station)}.to change{journey.exit_station}.to (station)
  end

end
