class JourneyLog

  def initialize(args)
    @journey_class = args[:journey_class]
    @log = []
  end

  def start(station)
    new_journey(station)
  end

  def finish(station)
    (prev_journey_exists_and_isnt_complete? ? log.last : new_journey).end_journey(station)
  end

  def journeys
    @log.clone
  end

  def current_journey
    log.last if log.last
  end

  private
  
  attr_reader :log

  def prev_journey_exists_and_isnt_complete?
    log.last && log.last.complete?
  end

  def new_journey(start_station = nil)
    log << @journey_class.new(start_station)
    log.last
  end

end
