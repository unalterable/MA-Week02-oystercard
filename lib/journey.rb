require_relative 'station'

class Journey
  MINIMUM_FARE = 1
  attr_reader :entry_station
  attr_reader :exit_station

  def initialize(station)
    @entry_station = station
  end

  def set_exit(station)
    @exit_station = station
  end

  def fare
    MINIMUM_FARE
  end
end
