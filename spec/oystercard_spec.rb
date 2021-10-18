require 'oystercard'

describe Oystercard do 
  describe '#balance' do 
    it 'checks if initial balance is zero' do 
      expect(subject.balance).to eq 0
    end

  end

end
