class Oystercard

  attr_reader :balance

  MAX_BALANCE = 90
  DEFAULT_BALANCE = 0

  def initialize(balance = DEFAULT_BALANCE, in_journey = false)
    @balance = balance
    @in_journey = in_journey
  end

  def top_up(amount)
    raise "Invalid top up. This card has a max limit of #{MAX_BALANCE}" if amount + balance > MAX_BALANCE
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def in_journey?
    @in_journey
  end

  def touch_in
    raise "Insufficient balance" if @balance <= 1
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end

end
