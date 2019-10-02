class Cli
  def splash
    system "clear"
    prompt = TTY::Prompt.new
    prompts = ["Sign in", "Create User", "Browse Coffee Shops", "Exit"]
    input = prompt.select("Get your PSL on! \nPlease select from the following menu options:", prompts )

    case input
    when prompts[0]
      Cli.new.sign_in
      
    when prompts[1]
      Cli.new.create_user
    when prompts[2]
      Cli.new.browse
    when prompts[3]
      "Goodbye"
      exit
    end
  end

  def sign_in
    system "clear"
    prompt = TTY::Prompt.new
    users_name = prompt.ask("What's your username?")
    if User.find_by(username: users_name)
      "you exist"
      portal(users_name)
    else
      prompt.yes?("You're not in our database! \nCheck your spelling, and try again?") ? sign_in : splash
    end
  end

  def create_user
    system "clear"
    prompt = TTY::Prompt.new
    # new_user = User.new
    boro = prompt.select("Where do you live?", ["Queens", "Bronx", "Manhattan", "Brooklyn", "Staten Island"])
    caffeine_intake = prompt.slider("How many caffeinated drinks do you consume per day?", min:1, max:5)
    name = prompt.ask("What's your name?")
    username = name.sub(" ","")
    dollaz = 5
    puts "Thanks for using our app! Here's $5 to get you started!"
    puts "Your username is #{username}, don't forget it!"

    User.create(name: name, username: username, home_location: boro, wallet: dollaz, psl_quota: caffeine_intake)
  end

  def portal(users_name)

    # Logic
    current_user = User.find_by(username: users_name)
    unique_cafes = current_user.psls.map {|psl| psl.coffee_shop}.uniq.count
    prompt = TTY::Prompt.new
    choices = ["Find an affordable option", "Find by rating", "Find a cult-classic", "Find a classic-bux", "Find a bistro"]

    # Screen text
    system "clear"
    puts "Hi, #{current_user.name}!"
    puts "You've got $#{current_user.wallet} in your PSL wallet"
    puts "You've visited #{unique_cafes} unique cafes!"
    choice = prompt.select("Where would you like to go next?", choices)

    case choice
    when choices[0]
      current_user.affordable #.display
    when choices[1]
      rating_min = prompt.slider("Minimum rating?", min:1, max:4).to_f
      current_user.shops_in_da_hood.select do |cafe|
        cafe.how_good_are_my_psls.to_f >= rating_min
      end.sample # .display
    when choices[2]
      current_user.shops_in_da_hood.select do |cafe|
        cafe.price_point == "$" && cafe.how_good_are_my_psls.to_f >= 3.0
      end.sample # .display
    when choices[3]
      current_user.shops_in_da_hood.select do |cafe|
        cafe.name.downcase.include?("starbuck")
      end.sample # .display
    when choices[4]
      current_user.shops_in_da_hood.select do |cafe|
        cafe.price_point == "$$$"
      end.sample # .display
    end
    
  end

  def display(users_name)
    #order
    current_user = User.find_by(username: users_name)


  end

  def display_no_order
    # Copy of above without any ordering methods.
  end

  # BROWSE NEEDS TESTING
  def browse(users_name=nil)
    system "clear"
    prompt = TTY::Prompt.new
    choices = ["Find a PSL!", "Best PSLs by boro", "Cult classics"]

    choice = prompt.select("What're you looking for?", choices)

    case choice
    when choices[0]
      # Find a certain coffee shop by critera
      location = prompt.select("Where do you want to enjoy your PSL?", ["Queens", "Bronx", "Manhattan", "Brooklyn", "Staten Island"])
      price = prompt.select("How much are you trying to spend on it?", ["$", "$$", "$$$", "Whatevs"])
      (price == "Whatevs") ? (price = nil) : price
      rating = prompt.slider("How good we talkin'?", min: 1, max: 4)

      cafehaus = CoffeeShop.select do |cafe|
        (cafe.location == location && (price.nil? ? true : cafe.price_point == price) && cafe.how_good_are_my_psls.to_f >= rating.to_f)
      end.sample
      
      cafehaus.nil? ? "#{location} has got nothing for you." : "test" # cafehaus.display_no_order


    when choices[1]
      # Best coffee shops in your boro
      location = prompt.select("Which boro?", ["Queens", "Bronx", "Manhattan", "Brooklyn", "Staten Island"])
      CoffeeShop.all.select do |cafe|
        (cafe.location == location && cafe.how_good_are_my_psls.to_f > 4.0)
      end.first(10) # . display as a list?
    when choices[2]
      # Top ten cult classics by boro
      # Display 10 "cult classics" per boro, side by side?
      puts "testing this still"

    end


  end
end