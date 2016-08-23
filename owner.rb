module Bank
  class Owner

    def initialize (id)
      @id = id
      puts "Enter first name:"
      @first_name = gets.chomp
      puts "Enter last name:"
      @last_name = gets.chomp
      puts "Enter street address"
      @address = gets.chomp
      puts "Enter city"
      @city = gets.chomp
      puts "Enter state"
      @state = gets.chomp
    end
  end
end
