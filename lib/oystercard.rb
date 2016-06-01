require_relative 'journey'

class Oystercard
  MAXIMUM_LIMIT = 90
  MINIMUM_FARE = Journey::MINIMUM_FARE
  MAX_LIM_ERR_MSG = "£#{MAXIMUM_LIMIT} is the maximum limit"
  MIN_LIM_ERR_MSG = "£#{MINIMUM_FARE} is the minimum limit"

  attr_reader :balance, :log, :journey

  def initialize
    @balance = 0
    @log = []
  end 

  def top_up(amount)
    fail MAX_LIM_ERR_MSG if @balance + amount > MAXIMUM_LIMIT
    @balance += amount
  end

  def touch_in(station)
    fail MIN_LIM_ERR_MSG if @balance < MINIMUM_FARE
    @journey = Journey.new
    @journey.start_journey(station)
  end

  def touch_out(station)
    journey.end_journey(station) if journey
    log << journey
    deduct(journey.fare)
    @journey = nil
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
