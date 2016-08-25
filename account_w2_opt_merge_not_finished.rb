require_relative 'owner'
require 'csv'

module Bank
  class Account
    attr_reader :balance

    def initialize (id, balance, open_date = Time.now)
      @id = id

      if balance >= 0
        @balance = balance
      else
        raise ArgumentError, "You can't start an account with a negative balance"
      end

      @date_opened = open_date

      # @owner = Bank::Owner.find(@id)
    end

# need to figure out how to merge the one array into the another array
    def self.all_with_owners
      acct_list_w_owners = []
      CSV.read('support/account_owners.csv').each do |line|
        a = Bank::Account.find(line[0].to_i)
        o = Bank::Owner.find(line[1].to_i)
        puts " "
        puts o
        # a.add_owner(0)
        # acct_list_w_owners << a
      end
    end

    def add_owner

    end

    # self.all - returns a collection of Account instances, representing all of the Accounts described in the CSV. See below for the CSV file specifications
    def self.all
      accounts = {}
      # /Documents/Ada/Week3/BankAccounts/support/accounts.csv
      CSV.read('support/accounts.csv').each do |line|
        accounts[line[0].to_i] = self.new(line[0].to_i, line[1].to_i, line[2])
      end
      return accounts
    end

    # self.find(id) - returns an instance of Account where the value of the id field in the CSV matches the passed parameter
    def self.find (id)
      accounts = self.all
      return accounts[id]
    end

    def withdraw (amt_withdrawn)
      if @balance - amt_withdrawn > 0
        @balance = @balance - amt_withdrawn
        return "$#{@balance/100}"
      else
        puts "Sorry, but you do not have that amount of money in your account."
        return "$#{@balance/100}"
      end
    end

    def deposit (amt_deposited)
      @balance = @balance + amt_deposited
      return "$#{@balance/100}"
    end

  end
end


# ID - (Fixnum) a unique identifier for that Account
# Balance - (Fixnum) the account balance amount, in cents (i.e., 150 would be $1.50)
# OpenDate - (Datetime) when the account was opened
