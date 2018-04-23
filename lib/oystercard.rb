class Oystercard

  attr_reader :balance

  MAX_BALANCE = 90
  DEFAULT_BALANCE = 0

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
  end

  def top_up(amount)
    raise "This card has reached its limit of #{MAX_BALANCE}" if limit_reached?
    @balance += amount
  end

private

  def limit_reached?
    balance >= MAX_BALANCE
  end

end
