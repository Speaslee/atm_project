require 'csv'
require 'pry'


class ATM
  attr_accessor :users, :current_user

  def initialize
    self.users = []
    load_users
    aut_pin
    menu_options
  end

  def load_users
    CSV.foreach("bank_names.csv", headers:true, header_converters: :symbol, converters: :all) do |row|
      u = User.new
      u.name = row[:name].to_s
      u.pin = row[:pin].to_s
      u.balance = row[:balance].to_i
      users<<u
    end
    aut_pin
  end

  def aut_pin
    puts "Please enter name:"
    user_input = gets.chomp
    puts "Please enter pin:"
    pin_input = gets.chomp

    self.current_user = users.find.each { |user| user.name == user_input && user.pin == pin_input }

    unless current_user
      puts "Please try entering your information again. Remember your name is case sensitive. "
      aut_pin
    end
    menu_options
  end


  def menu_options
    puts "Pick an option"
    puts "Please select 1 to withdraw:
    Please select 2 to check balance:
    Please select 3 to exit:"
    s=gets.chomp
    if s == "1"
      withdraw
    elsif s == "2"
      check_balance
    elsif s == "3"
      aut_pin
    else puts "Invalid Entry. Please try a different selection:"
      menu_options
    end
  end

  def withdraw
    puts "How much would you like to withdraw?"
    w= gets.chomp
    current_user.balance -= w.to_i
    options
  end

  def check_balance
    puts "Your balance is #{current_user.balance}"
    options
    end
  end

def options
  puts "Would you like to do anything else? Please type yes or no:"
  answer= gets.chomp
  if answer.downcase == "yes"
    menu_options
  elsif answer.downcase == "no"
    aut_pin
  else puts "Invalid Entry. Please type yes or no:"
    options
  end
end


class User
  attr_accessor :name, :pin, :balance
end


my_atm= ATM.new
