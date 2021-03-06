require 'oystercard'
require 'journey'
require 'station'

describe Oystercard do 

  #  station_name = double("double_station", :initialize => "Kings Cross") 
  #  station_zone = double("double_station", :initialize => 1)

  let(:entry_station) { double :station }
  let(:exit_station) { double :station }
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
      subject.touch_in(entry_station)
      
      expect(subject.in_journey).to be true
    end

    it 'don`t allow touch in if balance under minimum limit' do
      subject.top_up(Oystercard::MIN_FARE - 0.01)

      expect { subject.touch_in(entry_station) }.to raise_error "Not enough funds!"
    end

    it 'remember the entry station on the card when you touch in' do
      subject.top_up(Oystercard::MAX_LIMIT)
      subject.touch_in(entry_station)
      expect(subject.entry_station).to eq entry_station
    end

  end

  describe '#touch_out' do 
    it 'checks if touch_out method works on the card' do
      expect(subject).to respond_to(:touch_out)
    end

    it 'checks if in_journey? method works when touched out' do
      subject.top_up(Oystercard::MAX_LIMIT)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)

      expect(subject.in_journey).to be false
    end

    it 'Charge the card at the end of a journey when you touch out' do
      subject.top_up(Oystercard::MAX_LIMIT)
     

      expect { subject.touch_out(exit_station) }.to change { subject.balance }.by -Oystercard::MIN_FARE
    end

    it 'forget the entry station when touching out' do
      subject.top_up(Oystercard::MAX_LIMIT)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)

      expect(subject.entry_station).to eq nil
      
    end

    it 'remember the exit station on the card when you touch out' do
      subject.top_up(Oystercard::MAX_LIMIT)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)

      expect(subject.exit_station).to eq exit_station  
    end 

    it 'checks that touch in and touch out creates one journey' do
      subject.top_up(Oystercard::MAX_LIMIT)
      journey = Journey.new
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)

      expect(subject.journey.journey_list).to include({ :entry_station => entry_station, :exit_station => exit_station })
      
    end

  end

end
