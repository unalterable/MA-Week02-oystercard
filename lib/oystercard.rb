require_relative 'journey_log'

class Oystercard

  attr_reader :balance
  attr_reader :journeys

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  def initialize
    @balance = 0
    @journeys = JourneyLog.build
  end

  def top_up(amount)
    raise "Balance can't exceed 90" if amount + balance > MAXIMUM_BALANCE
    @balance += amount
  end

  def touch_in(station_object)
    raise "Already in a journey" if journeys.in_journey?
    raise "Not enough funds" if balance < MINIMUM_BALANCE
    journeys.begin(station_object)
  end

  def touch_out(station_object)
    raise "Not yet started journey" unless journeys.in_journey?
    journeys.finish(station_object)
    deduct(journeys.log.last.fare)
  end

private

  def deduct(amount)
    @balance -= amount
  end

end
