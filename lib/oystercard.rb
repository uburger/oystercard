class Oystercard
  MAX_LIMIT = 90
  MIN_FARE = 1
  attr_reader :balance, :in_journey

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(cash)
    fail "Can't top up above #{MAX_LIMIT}£" if (@balance + cash) > MAX_LIMIT
    @balance += cash
  end

  def touch_in
    fail "Not enough funds!" unless @balance > MIN_FARE
    puts "Barrier is now open - you may enter"
    @in_journey = true
  end

  def touch_out
    puts "Barrier is now open - you may exit"
    @in_journey = false

    deduct(MIN_FARE)
  end

private

  def deduct(fare)
    @balance -= fare
  end

end
