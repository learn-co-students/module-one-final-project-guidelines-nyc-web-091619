require_relative '../config/environment'
require 'tty-prompt'

prompt = TTY::Prompt.new

def greet
  puts "Welcome to the Bucket List!"
end

greet

# enter_name = prompt.ask("Please enter your first name:", default: ENV['USER']) do |q|
#   q.required true
#   q.validate /\A\w+\Z/
#   q.modify :capitalize
# end


prompt.ask("Please enter your first name:", required: true)


# find Travellers.all.find
# if not find


prompt.yes?("We're sorry, we could not find your account. Would you like to create one? (Y/N)")

#view items

prompt.select
("Please choose your destination")
