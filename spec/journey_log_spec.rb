require 'journey_log'

describe JourneyLog do

  subject(:journey_log) { described_class.new(journey_class_double) }

  let(:journey_class_double) {double :journey_class, :new => journey }
  let(:journey) {double :journey, :exit_station => nil, :set_exit => nil, :complete? => true}
  let(:station1) {double :station, :name => "Bank"}
  let(:station2) {double :station, :name => "Poplar"}

  describe '#initialize' do
    it 'checks that we have a journey variable' do
      expect(subject.log).to eq([])
    end
  
    it 'checks journey_log is initialized out of journey' do
      expect(journey_log.in_journey?).to eq(false)
    end
  end
 
  describe '#begin' do
    it 'creates a new log' do
      expect{journey_log.begin(station1)}.to change{journey_log.log.count}.by(1) 
    end
  end

  describe '#finish' do
      it 'stores the journey' do
        expect(journey).to receive(:set_exit)
        journey_log.finish(station1)
    end

    it 'finishing journey asks if journey is complete' do
      expect(journey).to receive(:complete?)
      journey_log.begin(station1)
      journey_log.finish(station2)
    end

  end
end
