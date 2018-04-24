class Journey

  attr_reader :entry_station, :exit_station

  MIN_FARE = 1
  PENALTY_FARE = 6

  def initialize(station)
    @entry_station = station
  end

  def finish_journey(station = 'unknown')
    @exit_station = station
  end

  def fare
    exit_station == 'unknown' ? PENALTY_FARE : MIN_FARE
  end

  def complete?
    !!exit_station
  end

end
