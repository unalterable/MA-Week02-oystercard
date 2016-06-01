require_relative 'station'

class Journey

  attr_reader :entry_station
  attr_reader :exit_station

  def initialize(station_name,station=Station.new(station_name))
    @entry_station = station
    @exit_station
  end

  def set_exit(station_name,station=Station.new(station_name))
    @exit_station = station
  end

end
