require 'oystercard'

describe Oystercard do

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
      expect(subject.deduct(5)).to eq 5
    end

  end
end
