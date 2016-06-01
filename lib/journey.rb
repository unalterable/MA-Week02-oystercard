class Journey
  MINIMUM_FARE = 1
  PENALTY_FARE = 6
  attr_reader :entry_station, :exit_station

  def initialize(station = nil)
    @entry_station = station
  end

  def end_journey(station)
    @exit_station = station
  end

  def complete?
    entry_station && exit_station
  end

  def fare
    complete? ? calculate_fare : PENALTY_FARE
  end

  private
  def calculate_fare
    1 + (entry_station.zone - exit_station.zone).abs
  end
end
