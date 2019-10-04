require 'tty-prompt'
prompt = TTY::Prompt.new

def greeting
  prompt = TTY::Prompt.new
  
  puts "
  +-+-+-+-+-+-+-+ +-+-+ +-+-+-+ +-+-+-+-+-+-+ +-+-+-+-+-+
  |W|e|l|c|o|m|e| |t|o| |t|h|e| |B|u|c|k|e|t| |L|i|s|t|!|
  +-+-+-+-+-+-+-+ +-+-+ +-+-+-+ +-+-+-+-+-+-+ +-+-+-+-+-+
  "

  name = prompt.ask("Please enter your name to get started:", required: true)
  current_user = Traveller.find_or_create_by(name: name)
  system "clear"
  show_menu(current_user)
end


def trips(current_user)
  current_user.destinations.map do |destination|
    system "clear"
    puts destination.city
  end 
end 


def check_in(current_user)
  target = Travellerdestination.find_by(traveller_id: current_user.id)
  system "clear"
  target.update(checkin: "Yes")
end


def delete_destination(current_user)
  prompt = TTY::Prompt.new
  yes_no = ["Yes", "No"]
  delete_or_not = prompt.select("Do you want to delete your last trip?", yes_no)
   if delete_or_not == "Yes"
    trips(current_user)
      current_user.travellerdestinations.last.destroy
      puts "Your trips have been cancelled"
   else delete_or_not == "No"
      trips
      puts "Your trips all still G-double O-D, Good!"
   end
end


def return_main_menu(current_user, prompt)
  return_options = ['Return to the main menu', 'Exit Program']
  return_menu = prompt.select("Please select from the following:", return_options)
    if return_menu == 'Return to the main menu'
      show_menu(current_user)
    elsif return_menu == 'Quit Program'
      abort('Goodbye!')
    end
end


def show_menu(current_user)
  prompt = TTY::Prompt.new
  
  menu_options = ['Book your future destinations!','View your current destination(s)','Check In','Cancel your trip','Exit Program']
  
  selection = prompt.select("Please select from the following:", menu_options)
  
  if selection == 'Book your future destinations!'
    destination_choices = ['Brekkemouth', 'Ethanstad', 'Gutkowskiburgh', 'Senaberg', 'Schusterborough']
      puts 'Book your future destinations!'
      destination_selection = prompt.select('Please choose your destination',destination_choices)
      matched_destination = Destination.all.find_by(city: destination_selection)
      current_trip = current_user.add_trip(matched_destination)

      puts "
      +-+-+-+-+-+ +-+-+-+-+ +-+-+-+-+ +-+-+-+-+ +-+-+-+ +-+-+-+-+ +-+-+-+-+-+-+-+-+-+-+
      |T|h|a|n|k| |y|o|u|,| |y|o|u|r| |T|r|i|p| |h|a|s| |b|e|e|n| |c|o|n|f|i|r|m|e|d|!|
      +-+-+-+-+-+ +-+-+-+-+ +-+-+-+-+ +-+-+-+-+ +-+-+-+ +-+-+-+-+ +-+-+-+-+-+-+-+-+-+-+
      "

      return_main_menu(current_user, prompt)


  elsif selection == 'View your current destination(s)'
    puts 'View your current destination(s)'
    trips(current_user)
    puts "Safe Travels!"
    return_main_menu(current_user, prompt)

  elsif selection == "Check In"
    puts "It's time to check in!"
    check_in(current_user)
    system "clear"
    puts "All checked in!"
    return_main_menu(current_user, prompt)
        
  elsif selection == 'Cancel your trip'
    puts 'Cancelling? We got it!'
    delete_destination(current_user)
    system "clear"
    puts "Sorry to see you go!"
    return_main_menu(current_user, prompt)

  elsif selection == 'Exit Program'
    abort("Goodbye!")
  end

end #End of CLI APP Class



