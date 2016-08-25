require 'csv'

module Bank
  class Owner

    def initialize (id, last_name, first_name, street_address, city, state)
      @id = id
      # puts "Enter last name:"
      @last_name = last_name
      # puts "Enter first name:"
      @first_name = first_name
      # puts "Enter street address"
      @street_address = street_address
      # puts "Enter city"
      @city = city
      # puts "Enter state"
      @state = state
    end

    # self.all - returns a collection of Owner instances, representing all of the Owners described in the CSV. See below for the CSV file specifications
    def self.all
      owners = {}
      CSV.read('support/owners.csv').each do |line|
        owners[line[0].to_i] = self.new(line[0].to_i, line[1], line[2], line[3], line[4], line[5])
      end
      return owners
    end

    # self.find(id) - returns an instance of Owner where the value of the id field in the CSV matches the passed parameter
    def self.find (id)
      owners = self.all
      return owners[id]
    end
  end
end


    # Bank::Owner
    # The data, in order in the CSV, consists of:
    # ID - (Fixnum) a unique identifier for that Owner
    # Last Name - (String) the owner's last name
    # First Name - (String) the owner's first name
    # Street Addess - (String) the owner's street address
    # City - (String) the owner's city
    # State - (String) the owner's state
