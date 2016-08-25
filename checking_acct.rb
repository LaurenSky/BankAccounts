require_relative 'account.rb'

module Bank
  class CheckingAccount < Account
    attr_reader :num_of_checks_used, :balance, :id

    def initialize (id, balance, open_date = Time.now )
      super(id, balance, open_date)
      # @date_opened = open_date
      @num_of_checks_used = 0
    end

    def withdraw (amount)
      # Does not allow the account to go negative. Will output a warning message and return the original un-modified balance.
      @withdrawal_fee = 1   #$1 checking account withdrawal fee taken out of the balance. Returns the updated account balance.
      if (@balance - amount - @withdrawal_fee) >= 0
        @balance = @balance - amount - @withdrawal_fee
        return "$#{@balance}"
      else
        puts "Sorry, but you do not have that amount of money in your account."
        return "$#{@balance}"
      end
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
        if (@balance - amount - @check_withdrawel_fee) >= -10
          @num_of_checks_used += 1
          return @balance = @balance - amount - @check_withdrawel_fee
        else
          puts "Sorry, but you do not have that amount of money in your account."
          return "$#{@balance}"
        end

      else

        if (@balance - amount) >= -10
          @num_of_checks_used += 1
          return @balance = @balance - amount
        else
          puts "Sorry, but you do not have that amount of money in your account."
          return "$#{@balance}"
        end
      end
    end

  end
end

# p = Bank::CheckingAccount.new(1234, 60000)
# puts p.withdraw_using_check(100)
# puts p.num_of_checks_used
# puts p.withdraw_using_check(100)
# puts p.num_of_checks_used
# puts p.withdraw_using_check(100)
# puts p.num_of_checks_used



# puts p
    # Allows the account to go into overdraft up to -$10 but not any lower
    # The user is allowed 3 free check uses in one month, but any subsequent use adds a $2 transaction fee
    # 3 free check uses, then a fee until we call the reset_checks method to reset. Do not use time in this.
