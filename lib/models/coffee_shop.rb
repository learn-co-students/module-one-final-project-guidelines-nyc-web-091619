class CoffeeShop < ActiveRecord::Base
  has_many :psls
  has_many :users, through: :psls

  def price_point
    if self.cost_per_size >= 0.10 && self.cost_per_size < 0.18
      "$"
    elsif self.cost_per_size >= 0.18 && self.cost_per_size < 0.25
      "$$"
    else
      "$$$"
    end
  end

  def how_good_are_my_psls
    psls_with_ratings = self.psls.select do |psl|
      psl.rating
    end
    psl_rating_array = psls_with_ratings.map do |psl|
      psl.rating.to_f
    end
    psl_rating_sum = psl_rating_array.reduce do |sum, rating|
      sum + rating
    end
    psl_rating_avg = (psl_rating_sum / psls_with_ratings.count) unless psl_rating_sum.nil?
    psl_rating_avg.nil? ? "\b\b\b\b\b\b\bn't rated by anyone" : psl_rating_avg.round(1)
  end


  def display(username=nil)
    ## Logic
    readable_name = self.name.split.map{|word| word.capitalize}.join(" ")
    psl_rating = self.how_good_are_my_psls
    if username.nil?
      choices = [{name: "Order", disabled: "-Please create an account"}, {name: "back"}]
    else
      choices = [{name: "Order"}, {name: "back"}]
    end
    prompt = TTY::Prompt.new
    font = TTY::Font.new(:straight)
    colors = Pastel.new
    
    ## Display Text
    system 'clear'
    puts colors.red(font.write("#{readable_name}"))
    puts "Welcome to #{readable_name}, in the boro of #{self.location}." 
    puts "Our Pumpkin Spice Lattes are rated #{psl_rating}, and we've sold #{self.psls.count}."
    puts "_.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._.-._"
    puts "Our small PSL costs $#{Psl.small(self).cost}"
    puts "Our medium PSL costs $#{Psl.medium(self).cost}"
    puts "Our large PSL costs $#{Psl.large(self).cost}"

    selection = prompt.select("Would you like anything?", choices)
    case selection
    when choices[0].values[0]
      order(username)
    when choices[1].values[0]
      if username.nil?
        Cli.new.browse(username)
      else
        Cli.new.portal(username)
      end
      puts "Shouldn't be here." # Debugging
      sleep 5
    end

    ## End of display

    # ## Start of #order
    # choices = [{name: "small"}, {name: "medium"}, {name: "large"}, {name: "exit"}]
    # if username.nil?
    #   choices = choices.map do |choice|
    #     if choice[:name] == "exit" 
    #       choice[:name] = "exit"
    #     else
    #       choice.merge({disabled: "account required"})
    #     end
    #   end
    # else
    #   current_user = User.find_by(username: username)
    # end
    # prompt = TTY::Prompt.new
    # size = prompt.select("What would you like to order?", choices)
    # case size
    # when choices[0].values[0]
    #   size = 12
    # when choices[1].values[0]
    #   size = 16
    # when choices[2].values[0]
    #   size = 20
    # when choices[3].values[0]
    #   exit
    # end
    # #dairy option
    # dairy_option = prompt.select("What type of milk would you like?", ["Oat Milk", "Soy Milk", "Half and Half", "Almond Milk", "Beef Milk"])

    # sweetener = prompt.select("What type of sweetener would you like?", ["Honey", "Agave", "Stevia", "Syrup", "Sugar in the Raw"])
    # sweetness = prompt.slider("How sweet would you like your PSL?", min: 1, max: 5)
    # iced = prompt.yes?("Would you like your PSL iced?")
    # whip = prompt.yes?("Would you like whip cream on your PSL?")
    # shot_choice = prompt.slider("How many espresso shots would you like?", min: 1, max: 4)

    # # readback = "So you'd like a #{size}oz "
    # temp_psl = Psl.new( 
    #   coffee_shop_id: self.id, 
    #   user_id: current_user.id,
    #   size: size,
    #   dairy_opt: dairy_option,
    #   sweetener: sweetener,
    #   sweetness: sweetness,
    #   iced?: iced,
    #   whip?: whip,
    #   shots: shot_choice,
    #   paid?: false
    # )
    # if prompt.yes?("This will cost $#{temp_psl.cost}. Sound good?")
    #   temp_psl.update(paid?: true)
    #   temp_psl.save
    #   current_user.update(wallet: (current_user.wallet - temp_psl.cost))
    # else
    #   Cli.new.splash
    # end

    # ## End of #order

    # ## start of post_pay_rate
    
    # ### Stretch -- put a spinner and sleep timer for waiting for your coffee
    # rating = prompt.slider("Please rate your coffee!", min:1, max:5)
    # temp_psl.update(rating: rating)
    # if rating == 1
    #   if prompt.yes?("So sorry to hear you didn't enjoy your coffee, would you like a refund?") && temp_psl.paid?
    #     temp_psl.update(paid?: false)
    #     current_user.update(wallet: (current_user.wallet + temp_psl.cost))
    #     puts "Hope it's better next time!"
    #     sleep 5
    #     Cli.new.portal(current_user.username)
    #   else
    #     Cli.new.portal(current_user.username)
    #   end
    # else
    #   puts "Thanks for rating!"
    #   puts "We hope you enjoyed your coffee!"
    #   sleep 5
    #   Cli.new.portal(current_user.username)
    # end
    # ## end of post_pay_rate
  end

  def order(username)
    choices = [{name: "small", value: 12}, {name: "medium", value: 16}, {name: "large", value: 20}, {name: "back"}]
    # if username.nil?
    #   choices = choices.map do |choice|
    #     if choice[:name] == "exit" 
    #       choice[:name] = "exit"
    #     else
    #       choice.merge({disabled: "account required"})
    #     end
    #   end
    # else
    # end
    current_user = User.find_by(username: username)
    prompt = TTY::Prompt.new
    size = prompt.select("What would you like to order?", choices)
    if size.class != Integer
      display(username)
    end

    dairy_option = prompt.select("What type of milk would you like?", ["Oat Milk", "Soy Milk", "Half and Half", "Almond Milk", "Beef Milk"])

    sweetener = prompt.select("What type of sweetener would you like?", ["Honey", "Agave", "Stevia", "Syrup", "Sugar in the Raw"])

    sweetness = prompt.slider("How sweet would you like your PSL?", min: 1, max: 5)

    iced = prompt.yes?("Would you like your PSL iced?")
    
    whip = prompt.yes?("Would you like whip cream on your PSL?")
    
    shot_choice = prompt.slider("How many espresso shots would you like?", min: 1, max: 4)

    # readback = "So you'd like a #{size}oz "
    temp_psl = Psl.new( 
      coffee_shop_id: self.id, 
      user_id: current_user.id,
      size: size,
      dairy_opt: dairy_option,
      sweetener: sweetener,
      sweetness: sweetness,
      iced?: iced,
      whip?: whip,
      shots: shot_choice,
      paid?: false
    )
    condition_cost = prompt.yes?("This will cost $#{temp_psl.cost}. Sound good?")
    if condition_cost && (current_user.wallet >= temp_psl.cost)
      temp_psl.update(paid?: true)
      temp_psl.save
      current_user.update(wallet: (current_user.wallet - temp_psl.cost))
      post_pay_rate(username, temp_psl)
    elsif condition_cost && (current_user.wallet < temp_psl.cost)
      puts "You can't afford this!"
      puts "Go deposit some more money in your portal"
      puts "Sending you back to the portal ..."
      sleep 2
      Cli.new.portal(username)
    else
      puts "Sending you back to the coffee shop ..."
      sleep 2
      display(username)
    end
  end

  def post_pay_rate(username, psl)
    font = TTY::Font.new(:straight)
    colors = Pastel.new
    prompt = TTY::Prompt.new
    current_user = User.find_by(username: username)

    system 'clear'
    
    puts colors.yellow.bold(font.write("Enjoy!"))
    rating = prompt.slider("Please rate your coffee!", min:1, max:5)
    temp_psl = psl
    temp_psl.update(rating: rating)
    if rating == 1
      if prompt.yes?("So sorry to hear you didn't enjoy your coffee, would you like a refund?") && temp_psl.paid?
        temp_psl.update(paid?: false)
        current_user.update(wallet: (current_user.wallet + temp_psl.cost))
        puts "Hope it's better next time!"
        sleep 5
        Cli.new.portal(username)
      else
        puts "Thanks for the feedback, we hope you enjoy your next one much more!"
        Cli.new.portal(username)
      end
    else
      puts "Thanks for rating!"
      puts "We hope you enjoyed your coffee!"
      sleep 5
      Cli.new.portal(username)
    end
  end

end #end of class


### The code I wish I had
## CoffeeShop#Display
#   carries in user from portal
#   displays coffee shop prices and small display
#   Provides option to order or exit
#   Exit returns user to their portal or if user=nil, returns user to Cli#browse
#   Order leads to CoffeeShop#Order
#
## CoffeeShop#Order
#   carries in user from #display
#   goes through ordering list
#   Reads the order back
#   'Sound good?'(y/n)
#   Y performs transaction, leads to CoffeeShop#post_pay_rate, N leads back to CoffeeShop#display
#
## CoffeeShop#post_pay_rate
#   carries in user from #order
#   allows the user to rate from 1-5
#   if rating is 1, allows choice for a refund
#   if yes, performs refund, sends back to portal
#   if no, thanks for feedback, sends back to portal
#   else takes rating, sends back to portal