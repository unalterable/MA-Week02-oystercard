require 'oystercard'

describe Oystercard do

  subject(:oystercard) { described_class.new }

  let(:max_bal) { Oystercard::MAXIMUM_BALANCE }
  let(:min_bal) { Oystercard::MINIMUM_BALANCE }
  let(:min_fare) { Oystercard::MINIMUM_FARE }
  
  let(:journey) {double (:journey)}
  let(:station1) {double (:station)}
  let(:station2) {double (:station)}

  context 'upon initialization' do

    it 'checks new oystercard has zero balance' do
      expect(oystercard.balance).to eq(0)
    end

    it 'checks that we have a journey variable' do
      expect(oystercard.journeys).to eq([])
    end

  end

  context '#top_up' do

    it 'responds to top up method' do
      expect(oystercard).to respond_to(:top_up).with(1).argument
    end

    it 'adds money to oystercard' do
      expect{ oystercard.top_up(1) }.to change{ oystercard.balance }.by(1)
    end

    it 'does not allow balance to exceed maximum' do
      message = "Balance can't exceed #{max_bal}"
      expect{oystercard.top_up(max_bal + 1)}.to raise_error(message)
    end

  end

  context '#touch_in' do

    it 'responds to touch_in method with one argument' do
      expect(oystercard).to respond_to(:touch_in).with(1).argument
    end

    it 'checks oystercard is initialized out of journey' do
      expect(oystercard.in_journey?).to eq(false)
    end

    it 'touching in changes status of oystercard to in journey' do
      oystercard.top_up(min_bal)
      oystercard.touch_in(station1)
      expect(oystercard.in_journey?).to eq(true)
    end

    it 'checks oystercard is not in a journey before touching in' do
      oystercard.top_up(min_bal)
      message = "Already in a journey"
      oystercard.touch_in(station1)
      expect{oystercard.touch_in(station1)}.to raise_error(message)
    end

    it 'will not allow touch in if funds are below minimum' do
      message = "Not enough funds"
      expect{oystercard.touch_in(station1)}.to raise_error(message)
    end

    it 'remembers the entry station' do
      oystercard.top_up(min_bal)
      oystercard.touch_in(station1)
      expect(oystercard.journeys.last[:entry_station]).to eq(station1)
    end

    it 'creates a new journey object with entry_station' do
      oystercard.top_up(min_bal)
      allow(journey).to receive(:entry_station) {station1}
      allow(station1).to receive(:name) {"Bank"}
      expect(oystercard.touch_in("Bank", journey)).to eq(journey)  
    end

  end

  context '#touch_out' do

    it 'responds to touch_out method with one argument' do
      expect(oystercard).to respond_to(:touch_out).with(1).argument
    end

    it 'checks oystercard is in a journey before touching out' do
      message = "Not yet started journey"
      expect{oystercard.touch_out(station2)}.to raise_error(message)
    end

    it 'touching out changes status of oystercard to not in journey' do
      oystercard.top_up(min_bal)
      oystercard.touch_in(station1)
      oystercard.touch_out(station2)
      expect(oystercard.in_journey?).to eq(false)
    end

    it 'deducts the balance by a minimum fare' do
      oystercard.top_up(10)
      oystercard.touch_in(station1)
      expect{oystercard.touch_out(station2)}.to change{oystercard.balance}.by(-min_fare)
    end

    it 'stores the journey' do
      oystercard.top_up(min_bal)
      oystercard.touch_in(station1)
      expect{oystercard.touch_out(station2)}.to change{oystercard.journeys.last}.to include(:exit_station => station2)
    end

    it 'modifies the journey object to set exit station' do
      oystercard.top_up(min_bal)
      allow(journey).to receive(:entry_station) {station1}
      allow(station1).to receive(:name) {"Bank"}
      oystercard.touch_in("Bank", journey)
      allow(journey).to receive(:set_exit) {station2}
      allow(journey).to receive(:exit_station) {station2}
      allow(station2).to receive(:name) {"Poplar"}
      expect(oystercard.touch_out("Poplar")).to eq(journey)
    end

  end

end
