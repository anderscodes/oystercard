class Oystercard

  attr_reader :balance

  MAX_BALANCE = 90
  DEFAULT_BALANCE = 0

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
  end

  def top_up(amount)
    raise "Invalid top up. This card has a max limit of #{MAX_BALANCE}" if amount + balance > MAX_BALANCE
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

end
