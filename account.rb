require_relative 'owner'
require 'csv'

module Bank
  class Account
    attr_reader :balance

    def initialize (id, balance, open_date = Time.now)
      @id = id
      @min_balance = 0
      if balance >= @min_balance
        @balance = balance/100
      else
        raise ArgumentError, "You can't start an account with a negative balance"
      end

      @date_opened = open_date
      #@owner = Bank::Owner.new(@id)
      @withdrawal_fee = 0
    end

    # self.all - returns a collection of Account instances, representing all of the Accounts described in the CSV. See below for the CSV file specifications
    def self.all
      accounts = {}
      # /Documents/Ada/Week3/BankAccounts/support/accounts.csv
      CSV.read('support/accounts.csv').each do |line|
        accounts[line[0]] = self.new(line[0], line[1].to_i, line[2])
      end
      return accounts
    end

    # self.find(id) - returns an instance of Account where the value of the id field in the CSV matches the passed parameter
    def self.find (id)
      accounts = self.all
      return accounts[id]
    end

    def withdraw (amount)
      if (@balance - amount - @withdrawal_fee) >= @min_balance
        @balance = @balance - amount - @withdrawal_fee
        return "$#{@balance}"
      else
        puts "Sorry, but you do not have that amount of money in your account."
        return "$#{@balance}"
      end
    end

    # Does not allow the account to go negative. Will output a warning message and return the original un-modified balance.
       #$1 checking account withdrawal fee taken out of the balance. Returns the updated account balance.

    def deposit (amt_deposited)
      @balance = @balance + amt_deposited
      return "$#{@balance}"
    end

  end
end
