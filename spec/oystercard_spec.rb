require 'oystercard'

describe Oystercard do

  subject(:oystercard) { described_class.new }

  let(:max_bal) { Oystercard::MAXIMUM_BALANCE }
  let(:min_bal) { Oystercard::MINIMUM_BALANCE }
  
  let(:station1) {double :station, :name => "Bank"}
  let(:station2) {double :station, :name => "Poplar"}

  context 'upon initialization' do

    it 'checks new oystercard has zero balance' do
      expect(oystercard.balance).to eq(0)
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

    it 'will not allow touch in if funds are below minimum' do
      message = "Not enough funds"
      expect{oystercard.touch_in(station1)}.to raise_error(message)
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

    it 'changes the balance' do
      oystercard.top_up(10)
      oystercard.touch_in(station1)
      expect{oystercard.touch_out(station2)}.to change{oystercard.balance}
    end

  end

end
