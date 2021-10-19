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

  describe '#touch_in' do 
    it 'checks if touch_in method works on the card' do
      expect(subject).to respond_to(:touch_in)
    end

    it 'checks if in_journey? method works when touched in' do
      subject.top_up(Oystercard::MAX_LIMIT)
      station = Station.new
      subject.touch_in(station)
      
      expect(subject.in_journey).to be true
    end

    it 'don`t allow touch in if balance under minimum limit' do
      subject.top_up(Oystercard::MIN_FARE - 0.01)
      station = Station.new

      expect { subject.touch_in(station) }.to raise_error "Not enough funds!"
    end

    it 'remember the entry station on the card when you touch in' do
      subject.top_up(Oystercard::MAX_LIMIT)
      euston = Station.new
      subject.touch_in(euston)

      expect(subject.entry_station).to eq euston
    end

  end

  describe '#touch_out' do 
    it 'checks if touch_out method works on the card' do
      expect(subject).to respond_to(:touch_out)
    end

    it 'checks if in_journey? method works when touched out' do
      subject.top_up(Oystercard::MAX_LIMIT)
      station = Station.new
      subject.touch_in(station)
      subject.touch_out

      expect(subject.in_journey).to be false
    end

    it 'Charge the card at the end of a journey when you touch out' do
      subject.top_up(Oystercard::MAX_LIMIT)

      expect { subject.touch_out }.to change { subject.balance }.by -Oystercard::MIN_FARE
    end

  end

end
