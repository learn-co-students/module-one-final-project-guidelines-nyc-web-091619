require_relative '../config/environment'
require 'tty-prompt'

prompt = TTY::Prompt.new

puts "Welcome to the Bucket List!"

enter_name = prompt.ask("Please enter your first name:", default: ENV['USER'])
# find Travellers.all.find
# if not find


prompt.yes?("We're sorry, we could not find your account. Would you like to create one? (Y/N)")

#view items

prompt.select
("Please choose your desintation")
