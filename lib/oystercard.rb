require_relative 'journey_log'

class Oystercard

  attr_reader :balance
  attr_reader :journeys
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  BALANCE_ERRS = { max: "Balance can't exceed #{MAXIMUM_BALANCE}",
                   min: "Balance can't fall below #{MINIMUM_BALACE}"}

  
  def initialize
    @balance = 0
    @journeys = JourneyLog.build
  end

  def top_up(amount)
    raise BALANCE_ERRS[:max] if amount + balance > MAXIMUM_BALANCE
    @balance += amount
  end

  def touch_in(station_object)
    raise BALANCE_ERRS[:min] if balance < MINIMUM_BALANCE
    journeys.begin(station_object)
  end

  def touch_out(station_object)
    journeys.finish(station_object)
    deduct(journeys.log.last.fare)
  end

private

  def deduct(amount)
    @balance -= amount
  end

end
