class Journey

  attr_reader :entry_station, :exit_station

  MIN_FARE = 1
  PENALTY_FARE = 6

  def initialize(station)
    @entry_station = station
  end

  def finish_journey(station)
    @exit_station = station
  end

  def fare
    if exit_station
       MIN_FARE
     else
       PENALTY_FARE
     end
  end

end
