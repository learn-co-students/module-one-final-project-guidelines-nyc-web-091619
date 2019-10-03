require 'tty-prompt'
prompt = TTY::Prompt.new

def greeting
  prompt = TTY::Prompt.new
  puts "Welcome to the Bucket List!"

  name = prompt.ask("Please enter your name to get started:", required: true)
  new_traveller = Traveller.create(name: name)
  show_menu(new_traveller)
end


def show_menu(new_traveller)
  prompt = TTY::Prompt.new

  menu_options = ['Book your future destinations!','View your current destination(s)','Change your current dates','Cancel destination(s)','Quit Program']

  selection = prompt.select("Please select from the following:", menu_options) 

  
  if selection == 'Book your future destinations!'
    destination_choices = ['Brekkemouth', 'Ethanstad', 'Gutkowskiburgh', 'Senaberg', 'Schusterborough']
      puts 'Book your future destinations!'
      destination_selection = prompt.select('Please choose your destination',destination_choices)
      matched_destination = Destination.all.find_by(city: destination_selection)
      current_trip = new_traveller.add_trip(matched_destination)
  elsif selection == 'View your current destination(s)'
    puts 'View your current destination(s)'
      
    





      # elsif selection == 'Change your current dates'
      #   change_dates = #need to create change dates options and updates to travellers dates, aka update functions
      # elsif selection == 'Cancel destination(s)'
      #   cancel_destinations = #need to create delete functions
    end
  end
  
