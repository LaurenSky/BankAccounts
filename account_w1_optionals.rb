require_relative 'owner'

module Bank
  class Account
    attr_reader :balance

    def initialize (init_balance)
      @id = rand(100..999)

      if init_balance > 0
        @balance = init_balance
      else
          raise ArgumentError, "You can't start an account with a negative balance"
      end
      @owner = Bank::Owner.new(@id)
    end

    def withdraw (amt_withdrawn)
      if @balance - amt_withdrawn > 0
        @balance = @balance - amt_withdrawn
        return "$#{@balance}"
      else
        puts "Sorry, but you do not have that amount of money in your account."
        return "$#{@balance}"
      end
    end

    def deposit (amt_deposited)
      @balance = @balance + amt_deposited
      return "$#{@balance}"
    end

  end
end

p = Bank::Account.new(500)
