require_relative 'account.rb'

module Bank
  class MoneyMarketAccount < Account
    attr_reader :id, :balance

    def initialize (id, balance, open_date = Time.now)
      super(id, balance, open_date)

      @min_balance = 10000
      puts @min_balance
      if (balance/100) >= @min_balance
        @balance = balance/100
      else
        raise ArgumentError, "You need at least $#{ @min_balance } to open a money market account."
      end

      @below_min_balance_fee = 100
      @num_of_transactions = 0
      @max_num_transactions = 6
    end

    def reset_transactions
      @num_of_transactions = 0
    end

    def transaction_limit_reached?
      @num_of_transactions >= @max_num_transactions
    end

    def charge_fee_for_overdraft? (amount)
      (@balance - amount) < @min_balance
    end

    def account_below_min_balance?
      @balance < @min_balance
    end

    def withdraw (amount)
      if transaction_limit_reached?
        puts "Sorry you have reached your maximum number of transactions/month of #{ @max_num_transactions }"
        return "$#{ @balance }"
      else

        if account_below_min_balance?
          return "Sorry, you can only deposit money at this point until your acount balance reaches the minimum acount balance of $#{ @min_balance }."
        else

          if charge_fee_for_overdraft?(amount)
            @balance = @balance - amount - @below_min_balance_fee
            @num_of_transactions += 1
            return "$#{ @balance }"
          else
            @balance = @balance - amount
            @num_of_transactions += 1
            return "$#{ @balance }"
          end
        end
      end
    end

    def deposit (amount)
      if account_below_min_balance?
        if (@balance + amount) >= @min_balance
          super(amount)
        else
          return "Sorry, you're account is frozen until you deposit enough money to reach the required min account balance of $#{ @min_balance }."
        end
      else
        if transaction_limit_reached?
          puts "Sorry you have reached your maximum number of transactions/month of #{ @max_num_transactions }"
          return "$#{ @balance }"
        else
          @num_of_transactions += 1
          super(amount)
        end
      end
    end

    def add_interest(rate)
      interest_rate = rate / 100
      interest_on_balance = @balance * interest_rate
      @balance = @balance + interest_on_balance
      return "$" + interest_on_balance.to_s
      # Example: If the interest rate is 0.25% and the balance is $10,000, then the interest that is returned is $25 and the new balance becomes $10,025.
    end

  end
end
