class Oystercard

  attr_reader :balance

  MAXIMUM_BALANCE = 90

  def initialize
    @balance = 0
  end

  def top_up(amount)
    @balance += amount
    raise "Balance can't exceed 90" if @balance > MAXIMUM_BALANCE
  end

end
