class Oystercard
  MAX_LIMIT = 90
  attr_reader :balance

  def initialize
    @balance = 0
  end

  def top_up(cash)
    if (@balance + cash) > MAX_LIMIT
      fail "Can't top up above #{MAX_LIMIT}£" 
    else
      return @balance += cash
    end
  end

end
