require 'station'

describe Station do

  subject(:station) { described_class.new("Tower Hill", 1) }

  context 'initialization'do
    
    it 'checks that name is initialized' do
      expect(station.name).to eq("Tower Hill")
    end

    it 'checks that zone is initialized' do
      expect(station.zone).to eq(1)
    end
  end
  
end