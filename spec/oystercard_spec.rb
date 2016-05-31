require 'oystercard'

describe Oystercard do

  context '#add_balance' do
    
    it 'checks new oystercard has zero balance' do
      expect(subject.balance).to eq(0)
    end

    it 'adds money to Oystercard' do
      expect(subject).to respond_to(:add_balance)
    end


  end

end
