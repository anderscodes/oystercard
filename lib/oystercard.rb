class Oystercard

  attr_reader :balance, :journeys

  MAX_BALANCE = 90
  DEFAULT_BALANCE = 0
  MIN_BALANCE = 1

  def initialize(balance = DEFAULT_BALANCE, in_journey = false)
    @balance = balance
    @in_journey = in_journey
    @journeys = []
    @current_journey = {}
  end

  def top_up(amount)
    raise "Amount must be positive" if amount.negative?
    raise "Invalid top up. This card has a max limit of #{MAX_BALANCE}" if over_balance?(amount)
    @balance += amount
  end

  def in_journey?
    !!@current_journey[:entry_station]
  end

  def touch_in(station)
    raise "Insufficient balance" if @balance <= MIN_BALANCE
    @in_journey = true
    @current_journey[:entry_station] = station
  end

  def touch_out(station)
    @in_journey = false
    deduct(MIN_BALANCE)
    @current_journey[:exit_station] = station
    save_journey
    reset_current_journey
  end

  private

  def deduct(amount)
    @balance -= amount
  end

  def save_journey
    journeys.push(@current_journey)
  end

  def reset_current_journey
    @current_journey = {}
  end

  def over_balance?(amount)
    amount + balance > MAX_BALANCE
  end

end
