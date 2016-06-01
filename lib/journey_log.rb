class JourneyLog

  def initialize(args)
    @journey_class = args[:journey_class]
    @log = []
  end

  def start(station)
    journey_to_start = new_journey(station)
    log << journey_to_start
  end

  def finish(station)
    journey_to_complete = no_journey_start_recorded? ? new_journey : log.last
    journey_to_complete.end_journey(station)
  end

  def journeys
    @log.clone
  end

  def current_journey
    no_journey_start_recorded? ? nil : log.last
  end

  private
  attr_reader :log
  def no_journey_start_recorded?
    !log.last || log.last.complete? 
  end

  def new_journey(start_station = nil)
    @journey_class.new(start_station)
  end

end
