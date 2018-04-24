class Oystercard

  attr_reader :balance, :entry_station

  MAX_BALANCE = 90
  DEFAULT_BALANCE = 0
  MIN_BALANCE = 1

  def initialize(balance = DEFAULT_BALANCE, in_journey = false)
    @balance = balance
    @in_journey = in_journey
  end

  def top_up(amount)
    raise "Invalid top up. This card has a max limit of #{MAX_BALANCE}" if amount + balance > MAX_BALANCE
    @balance += amount
  end

  def in_journey?
    !@entry_station.nil?
  end

  def touch_in(station)
    raise "Insufficient balance" if @balance <= MIN_BALANCE
    @in_journey = true
    @entry_station = station
  end

  def touch_out
    @in_journey = false
    deduct(MIN_BALANCE)
    @entry_station = nil
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
