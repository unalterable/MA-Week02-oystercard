require_relative 'station'

class Journey

  attr_reader :entry_station
  attr_reader :exit_station

  def initialize(station)
    @entry_station = station
  end

  def set_exit(station)
    @exit_station = station
  end

end
