require_relative '../config/environment'
require 'tty-prompt'

prompt = TTY::Prompt.new

def greet
  puts "Welcome to the Bucket List!"
end

greet

name = prompt.ask("Please enter your name to get started:", required: true)

new_traveller = Traveller.create(name: name)


prompt.select("Please select from the following:") do |option| 
  option.enum '.'
  option.choice 'View all of your future destinations!'
  option.choice 'View all of your current destinations'
  option.choice 'Change your dates'
  option.choice 'Cancel destinations'
end




prompt.multi_select("Please choose your destination", %w(
Brekkemouth,Greece
Ethanstad,Mauritania
Gutkowskiburgh,Mongolia
Senaberg,Liberia
Schusterborough,Samoa
))


