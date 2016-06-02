require_relative 'journey'

class Oystercard

  attr_reader :balance
  attr_reader :journeys

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  MINIMUM_FARE = 1

  def initialize
    @balance = 0
    @journeys = []
  end

  def top_up(amount)
    raise "Balance can't exceed 90" if amount + balance > MAXIMUM_BALANCE
    @balance += amount
  end

  def touch_in(station_object)
    raise "Already in a journey" if in_journey?
    raise "Not enough funds" if balance < MINIMUM_BALANCE
    journeys << Journey.new(station_object)
  end

  def touch_out(station_object)
    raise "Not yet started journey" unless in_journey?
    deduct(MINIMUM_FARE)
    journeys.last.set_exit(station_object)
  end

  def in_journey?
    return false if journeys.empty?
    journeys.last.exit_station == nil
  end

private

  def deduct(amount)
    @balance -= amount
  end

end
