require_relative 'account.rb'

module Bank
  class SavingsAccount < Account
    attr_reader :balance, :id

    def initialize (id, balance, open_date = Time.now)
      super(id, balance, open_date)
      # The initial balance cannot be less than $10. If it is, this will raise an ArgumentError
      @min_balance = 10
      if (balance/100) >= @min_balance
        @balance = balance/100
      else
        raise ArgumentError, "You need at least $#{ @min_balance } to open a savings account."
      end

      @withdrawal_fee = 2   #$2 withdrawal fee for saving acct

    end

    def withdraw (amount)
      super(amount)
    end

    def add_interest(rate)
      #add_interest(rate): Calculate the interest on the balance and add the interest to the balance. Return the interest that was calculated and added to the balance (not the updated balance).
      # Input rate is assumed to be a percentage (i.e. 0.25).
      # The formula for calculating interest is balance * rate/100
      interest_rate = rate / 100
      interest_on_balance = @balance * interest_rate
      @balance = @balance + interest_on_balance
      return "$" + interest_on_balance.to_s
      # Example: If the interest rate is 0.25% and the balance is $10,000, then the interest that is returned is $25 and the new balance becomes $10,025.
    end

  end
end
