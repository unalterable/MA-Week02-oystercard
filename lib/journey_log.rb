class JourneyLog
  attr_reader :journeys

  def initialize(args)
    @journey_class = args[:journey_class]
    @journeys = []
  end

  def start(station)
    @journeys << @journey_class.new(station)
  end

  def current_journey
    @journeys.last
  end

  def finish(station)
    current_journey.end_journey(station)
  end
end
