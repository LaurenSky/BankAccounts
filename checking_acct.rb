require_relative 'account.rb'

module Bank
  class CheckingAccount < Account
    attr_reader :num_of_checks_used, :balance, :id

    def initialize (id, balance, open_date = Time.now )
      super(id, balance, open_date)
      @num_of_checks_used = 0
      @withdrawal_fee = 1
      @min_balance_check = -10
    end

    def withdraw (amount)
      super (amount)
      # # Does not allow the account to go negative. Will output a warning message and return the original un-modified balance.
      #    #$1 checking account withdrawal fee taken out of the balance. Returns the updated account balance.
      # if (@balance - amount - @withdrawal_fee) >= 0
      #   @balance = @balance - amount - @withdrawal_fee
      #   return "$#{@balance}"
      # else
      #   puts "Sorry, but you do not have that amount of money in your account."
      #   return "$#{@balance}"
      # end
    end

    def charge_fee_for_check?
      @num_of_checks_used >= 3
    end

    #reset_checks: Resets the number of checks used to zero
    def reset_checks
      @num_of_checks_used = 0
    end

    # withdraw_using_check(amount): The input amount gets taken out of the account as a result of a check withdrawal. Returns the updated account balance.
    def withdraw_using_check (amount)
      @check_withdrawel_fee = 2         #$2 transaction fee
      if charge_fee_for_check?
        if (@balance - amount - @check_withdrawel_fee) >= @min_balance_check
          @num_of_checks_used += 1
          @balance = @balance - amount - @check_withdrawel_fee
          return "$#{ @balance }"
        else
          puts "Sorry, but you do not have that amount of money in your account."
          return "$#{ @balance }"
        end

      else

        if (@balance - amount) >= @min_balance_check
          @num_of_checks_used += 1
          @balance = @balance - amount
          return "$#{ @balance }"
        else
          puts "Sorry, but you do not have that amount of money in your account."
          return "$#{ @balance }"
        end
      end
    end
  end
end
