require 'station'

class Oystercard
  MAX_LIMIT = 90
  MIN_FARE = 1
  attr_reader :balance, :entry_station 

  def initialize
    @balance = 0
    @entry_station = nil
  end

  def top_up(cash)
    fail "Can't top up above #{MAX_LIMIT}£" if (@balance + cash) > MAX_LIMIT
    @balance += cash
  end

  def touch_in(station)
    fail "Not enough funds!" unless @balance > MIN_FARE
    puts "Barrier is now open - you may enter"
    @entry_station = station 
  end

  def touch_out
    puts "Barrier is now open - you may exit"   
    deduct(MIN_FARE)
    @entry_station = nil
  end

  def in_journey
    !!entry_station
  end

private

  def deduct(fare)
    @balance -= fare
  end

end
