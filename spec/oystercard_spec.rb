require 'oystercard'

describe Oystercard do 
  describe '#initialize' do 
    it 'checks if initial balance is zero' do 
      expect(subject.balance).to eq 0
    end

    it 'checks if new card is touched out' do
      expect(subject.in_journey).to be false
    end

  end

  describe '#top_up' do
    it 'checks if top_up takes argument' do
      expect(subject).to respond_to(:top_up).with(1).argument
    end

    it 'tops up the balance' do 
      expect { subject.top_up(25) }.to change { subject.balance }.by 25
    end

    it 'throws an error if limit exceeded' do 
      card = Oystercard.new
      card.top_up(Oystercard::MAX_LIMIT)
      
      expect { card.top_up(1) }.to raise_error "Can't top up above #{Oystercard::MAX_LIMIT}£"
    end
  end

  describe '#deduct' do 
    it 'checks if deduct takes argument' do
      expect(subject).to respond_to(:deduct).with(1).argument
    end
    
    it 'deduct fare from the balance' do 
      subject.top_up(10)

      expect { subject.deduct(5) }.to change { subject.balance }.by -5
  
    end

  end

  describe '#touch_in' do 
    it 'checks if touch_in method works on the card' do
      expect(subject).to respond_to(:touch_in)
    end

    it 'checks if in_journey? method works when touched in' do
      subject.touch_in
 
      expect(subject.in_journey).to be true
    end

  end

  describe '#touch_out' do 
    it 'checks if touch_out method works on the card' do
      expect(subject).to respond_to(:touch_out)
    end

    it 'checks if in_journey? method works when touched out' do
      subject.touch_in
      subject.touch_out

      expect(subject.in_journey).to be false
     end

  end

end
