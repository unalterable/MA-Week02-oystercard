class JourneyLog
  attr_reader :journeys, :current_journey

  def initialize(args)
    @journey_class = args[:journey_class]
    @journeys = []
  end

  def start(station)
    @current_journey = @journey_class.new(station)
  end

  def finish(station)
    journeys << (@current_journey || @journey_class.new).end_journey(station)
    @current_journey = nil
  end
end
