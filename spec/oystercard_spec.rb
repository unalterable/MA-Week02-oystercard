require 'oystercard'

describe Oystercard do

  subject(:oystercard) { described_class.new }
  
  let(:min_bal) { Oystercard::MINIMUM_BALANCE }

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

  context '#deduct' do

    it 'deducts money from oystercard' do
      subject.top_up(10)
      expect{subject.deduct(5)}.to change{subject.balance}.by(-5)
    end

  end

  context '#touch_in' do

    it 'responds to touch_in method with one argument' do
      expect(subject).to respond_to(:touch_in).with(1).argument
    end

    it 'checks oystercard is initialized out of journey' do
      expect(subject.in_journey).to eq(false)
    end

    it 'touching in changes status of oystercard to in journey' do
      subject.top_up(min_bal)
      station = :liverpool_street
      subject.touch_in(station)
      expect(subject.in_journey).to eq(true)
    end

    it 'checks oystercard is not in a journey before touching in' do
      subject.top_up(min_bal)
      message = "Already in a journey"
      station = :liverpool_street
      subject.touch_in(station)
      expect{subject.touch_in(station)}.to raise_error(message)
    end

    it 'will not allow touch in if funds are below minimum' do
      message = "Not enough funds"
      station = :liverpool_street
      expect{subject.touch_in(station)}.to raise_error(message)
    end

  end

    context '#touch_out' do

      it 'responds to touch_out method with one argument' do
        expect(subject).to respond_to(:touch_out).with(1).argument
      end

      it 'checks oystercard is in a journey before touching out' do
        message = "Not yet started journey"
        station = :bank
        expect{subject.touch_out(station)}.to raise_error(message)
      end

      it 'touching out changes status of oystercard to not in journey' do
        subject.top_up(min_bal)
        station = :liverpool_street
        subject.touch_in(station)
        station = :bank
        subject.touch_out(station)
        expect(subject.in_journey).to eq(false)
      end

    end

end
