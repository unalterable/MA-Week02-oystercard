require 'oystercard'

describe Oystercard do

  context '#top_up' do

    it 'checks new oystercard has zero balance' do
      expect(subject.balance).to eq(0)
    end

    it 'responds to top up method' do
      expect(subject).to respond_to(:top_up).with(1).argument
    end

    it 'adds money to oystercard' do
      expect{ subject.top_up(1) }.to change{ subject.balance }.by(1)
    end

  end

end
