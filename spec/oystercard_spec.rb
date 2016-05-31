require 'oystercard'

describe Oystercard do

  subject(:oystercard) { described_class.new }

  let(:min_bal) { Oystercard::MINIMUM_BALANCE }
  let(:min_fare) { Oystercard::MINIMUM_FARE }

  let(:station1) {double (:liverpool_street)}
  let(:station2) {double (:bank)}

  context '#top_up' do

    let(:max_bal) { Oystercard::MAXIMUM_BALANCE }

    it 'checks new oystercard has zero balance' do
      expect(subject.balance).to eq(0)
    end

    it 'responds to top up method' do
      expect(subject).to respond_to(:top_up).with(1).argument
    end

    it 'adds money to oystercard' do
      expect{ subject.top_up(1) }.to change{ subject.balance }.by(1)
    end

    it 'does not allow balance to exceed maximum' do
      message = "Balance can't exceed #{max_bal}"
      expect{subject.top_up(max_bal + 1)}.to raise_error(message)
    end

  end

  context '#touch_in' do

    it 'responds to touch_in method with one argument' do
      expect(subject).to respond_to(:touch_in).with(1).argument
    end

    it 'checks oystercard is initialized out of journey' do
      expect(subject.in_journey?).to eq(false)
    end

    it 'touching in changes status of oystercard to in journey' do
      subject.top_up(min_bal)
      subject.touch_in(station1)
      expect(subject.in_journey?).to eq(true)
    end

    it 'checks oystercard is not in a journey before touching in' do
      subject.top_up(min_bal)
      message = "Already in a journey"
      subject.touch_in(station1)
      expect{subject.touch_in(station1)}.to raise_error(message)
    end

    it 'will not allow touch in if funds are below minimum' do
      message = "Not enough funds"
      expect{subject.touch_in(station1)}.to raise_error(message)
    end

    it 'remembers the entry station' do
      subject.top_up(min_bal)
      expect{subject.touch_in(station1)}.to change{subject.entry_station}.to (station1)
    end
  end

  context '#touch_out' do

    it 'responds to touch_out method with one argument' do
      expect(subject).to respond_to(:touch_out).with(1).argument
    end

    it 'checks oystercard is in a journey before touching out' do
      message = "Not yet started journey"
      expect{subject.touch_out(station2)}.to raise_error(message)
    end

    it 'touching out changes status of oystercard to not in journey' do
      subject.top_up(min_bal)
      subject.touch_in(station1)
      subject.touch_out(station2)
      expect(subject.in_journey?).to eq(false)
    end

    it 'reduces the balance by a minimum fare' do
      subject.top_up(10)
      subject.touch_in(station1)
      expect{subject.touch_out(station2)}.to change{subject.balance}.by(-min_fare)
    end

    it 'makes the card forget the entry station upon touching out' do
      subject.top_up(min_bal)
      subject.touch_in(station1)
      expect{subject.touch_out(station2)}.to change{subject.entry_station}.to nil
    end
  end

end
