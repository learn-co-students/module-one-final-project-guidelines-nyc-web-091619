class Cli
  def splash
    system "clear"
    font = TTY::Font.new(:straight)
    prompt = TTY::Prompt.new
    colors = Pastel.new
    prompts = ["Sign in", "Create User", "Browse Coffee Shops", "Exit"]
    puts colors.yellow(font.write("b     It's"))
    puts colors.yellow(font.write("a     Pumpkin"))
    puts colors.yellow(font.write("s      Spice"))
    puts colors.yellow(font.write("i       Latte"))
    puts colors.yellow(font.write("c      Season"))

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
    # system "clear"
    prompt = TTY::Prompt.new
    username = prompt.ask("What's your username?")
    if User.find_by(username: username)
      "you exist"
      portal(username) # User.find_by(username:username).portal
    else
      prompt.yes?("You're not in our database! \nCheck your spelling, and try again?") ? sign_in : splash
    end
  end

  def create_user # Needs to validate against database
    system "clear"
    font = TTY::Font.new(:straight)
    colors = Pastel.new
    prompt = TTY::Prompt.new
    puts colors.yellow(font.write("Welcome to Basic!"))
    boro = prompt.select("Where do you live?", ["Queens", "Bronx", "Manhattan", "Brooklyn", "Staten Island"])
    caffeine_intake = prompt.slider("How many caffeinated drinks do you consume per day?", min:1, max:5)
    name = prompt.ask("What's your name?", required: true)
    username = name.gsub(" ","")
    dollaz = 5
    puts "Thanks for using our app! Here's $5 to get you started!"
    puts "Your username is #{username}, don't forget it!"

    User.create(name: name, username: username, home_location: boro, wallet: dollaz, psl_quota: caffeine_intake)#portal
    
    sleep 5

    portal(username)
  end

  def portal(username)
    current_user = User.find_by(username: username)
    unique_cafes = current_user.coffee_shops.uniq.count
    prompt = TTY::Prompt.new
    font = TTY::Font.new(:straight)
    colors = Pastel.new
    choices = ["Find an affordable option", "Find by rating", "Find a cult-classic", "Find a classic-bux", "Find a bistro", "Browse", "Deposit funds", "Log Out", "DELETE"]

    # Screen text
    system "clear"
    puts colors.magenta(font.write("most basic portal"))
    puts "Hi, #{current_user.name}!"
    puts "You've got $#{current_user.wallet.round(2)} in your PSL wallet"
    puts "You've visited #{unique_cafes} unique cafes!"
    choice = prompt.select("Where would you like to go next?", choices)

    case choice
    when choices[0]
      if current_user.affordable == "You'll never reach your quota if you don't deposit some funds"
        portal(username)
      else
        current_user.affordable.display(username)
      end
    when choices[1] 
      rating_min = prompt.slider("Minimum rating?", min:1, max:4).to_f
      current_user.shops_in_da_hood.select do |cafe|
        cafe.how_good_are_my_psls.to_f >= rating_min
      end.sample.display(username)
    when choices[2]
      current_user.shops_in_da_hood.select do |cafe|
        cafe.price_point == "$" && cafe.how_good_are_my_psls.to_f >= 3.0
      end.sample.display(username)
    when choices[3]
      current_user.shops_in_da_hood.select do |cafe|
        cafe.name.downcase.include?("starbuck")
      end.sample.display(username)
    when choices[4]
      current_user.shops_in_da_hood.select do |cafe|
        cafe.price_point == "$$$"
      end.sample.display(username)
    when choices[5]
      browse(username)
    when choices[6]
      num = prompt.ask("How much would you like to deposit?").to_f
      current_user.update(wallet: (current_user.wallet+num))
      portal(username)
    when choices[7]
      splash
    when choices[8]
      prompt.warn("This is serious, it will remove your account from the PSL database permanently.")
      if prompt.yes?("Are you sure about this?")
        prompt.error("Continuing will DELETE your account.")
        if prompt.yes?("Delete account?")
          current_user.delete
          prompt.ok("Successfully deleted your account, stay basic!")
          sleep 5
          Cli.new.splash
        end
      end
      portal(username) # current_user.portal
    end
  end

  def browse(username=nil)
    current_user = User.find_by(username: username)
    prompt = TTY::Prompt.new
    font = TTY::Font.new(:straight)
    colors = Pastel.new
    choices = ["Find a PSL!", "Best PSLs by boro", {name: "Cult classics", disabled: "<<-stretch->>"}, "Back"]
    system "clear"
    puts colors.magenta.bold(font.write("PSL Browser"))
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
      
      cafehaus.nil? ? "#{location} has got nothing for you." : cafehaus.display(username)

    when choices[1]
      # Best coffee shops in your boro
      location = prompt.select("Which boro?", ["Queens", "Bronx", "Manhattan", "Brooklyn", "Staten Island"])
      cafehauses = CoffeeShop.all.select do |cafe|
        (cafe.location == location && cafe.how_good_are_my_psls.to_f > 4.0)
      end.sample(10)
      # cafe_hash = {}
      cafe_list = []
      cafehauses.each do |cafe|
        cafe_hash = {}
        unless cafe.how_good_are_my_psls == nil?
          cafe_hash[:value] = cafe
          cafe_hash[:name] = "#{cafe.name} in #{location} PSL's are rated #{cafe.how_good_are_my_psls}"
          cafe_list << cafe_hash
        else
          cafe_hash[:value] = cafe
          cafe_hash[:name] = "#{cafe.name} is unrated, but we bet the PSLs are good. Be the first to try and rate!"
          cafe_list << cafe_hash
        end
      end
      binding.pry
      selection = prompt.select("Here are the ten best coffee shops in your boro:", cafe_list)
      selection.display(username)
      
    when choices[2]
      # Top ten cult classics by boro
      # Display 10 "cult classics" per boro, side by side?
      puts "testing this still"
    when choices[3]
      splash
    end
    
  end
end

### Code I wish I had
## Cli#Splash
#
#
#
#
#
#
#
## Cli#Sign_in
#   Takes username
#   Calls User#portal
#
#
#
## Cli#Create_account
#   prompts name, caffeine intake, location
#   creates new user
#   Calls user#portal
#
#
#
#
## Cli#Browse
#   prompts location
#
#
#
#
#
#