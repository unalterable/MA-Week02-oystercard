require './lib/oystercard'
card = Oystercard.new
station1 = Station.new("Bank")
station2 = Station.new("Poplar")
card.top_up(10)
card.touch_in(station1)
p card.journeys
card.touch_out(station2)
card.touch_in(station2)
card.touch_out(station1)
p card.journeys
