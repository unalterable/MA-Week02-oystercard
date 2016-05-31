class Oystercard

  attr_reader :balance
  attr_reader :in_journey


  MAXIMUM_BALANCE = 90

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    raise "Balance can't exceed 90" if amount + balance > MAXIMUM_BALANCE
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def touch_in(station)
    raise "Already in a journey" if in_journey
    @in_journey = true
  end

  def touch_out(station)
    raise "Not yet started journey" if in_journey == false
    @in_journey = false
  end

end
