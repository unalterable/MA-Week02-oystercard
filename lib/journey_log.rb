class JourneyLog
  attr_reader :journeys

  def initialize(args)
    @journey_class = args[:journey_class] || nil
    @journeys = []
  end

  def start(station)
    @journeys << @journey_class.new(station)
  end

  def current_journey
    @journeys.last
  end
end
