require_relative 'station'

class Journey
  MIN_FARE = 1
  PENALTY_FARE = 6
  
  attr_reader :entry_station
  attr_reader :exit_station

  def initialize(station)
    @entry_station = station
  end

  def set_exit(station)
    @exit_station = station
  end

  def fare
    complete? ? MIN_FARE : PENALTY_FARE
  end

  def complete?
    entry_station && exit_station
  end

end
