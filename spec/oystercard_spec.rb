require 'oystercard'

describe Oystercard do 
  describe '#balance' do 
    it 'checks if initial balance is zero' do 
      expect(subject.balance).to eq 0
    end
  end

  describe '#top_up' do
    it 'checks if top_up takes argument' do
      expect(subject).to respond_to(:top_up).with(1).argument
    end

    it 'tops up the balance' do 
      expect { subject.top_up(25) }.to change { subject.balance }.by 25
    end
  end
  

end
