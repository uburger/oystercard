require 'station'
require_relative 'journey'

class Oystercard
  MAX_LIMIT = 90
  MIN_FARE = 1
  attr_reader :balance 
  attr_accessor :journey, :trip, :entry_station, :exit_station

  def initialize
    @balance = 0
    @entry_station = nil
    @exit_station = nil
    @trip = {}
    @journey = Journey.new
  
  end

  def top_up(cash)
    fail "Can't top up above #{MAX_LIMIT}£" if (@balance + cash) > MAX_LIMIT
    @balance += cash
  end

  def touch_in(station)
    fail "Not enough funds!" unless @balance > MIN_FARE
    @entry_station = station 
  end

  def touch_out(station)  
    deduct(MIN_FARE)
    @exit_station = station
    @trip = { :entry_station => @entry_station, :exit_station => @exit_station }
    @journey.journey_list.push(@trip)
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
