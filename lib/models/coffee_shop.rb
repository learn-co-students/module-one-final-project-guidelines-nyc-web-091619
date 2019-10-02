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
    psl_rating_avg.nil? ? "No ratings" : psl_rating_avg.round(1)
  end


  def display(users_name=nil)
    #order
    # when users_name.nil? blank out ordering options
    readable_name = self.name.split.map{|word| word.capitalize}.join(" ")
    psl_rating = self.how_good_are_my_psls
    puts "Welcome to #{readable_name}." 
    puts "Our psls are rated by #{psl_rating}."
    puts "Our small PSL costs $#{Psl.small(self).cost}"
    puts "Our medium PSL costs $#{Psl.medium(self).cost}"
    puts "Our large PSL costs $#{Psl.large(self).cost}"
    choices = [{name: "small"}, {name: "medium"}, {name: "large"}, {name: "back"}]
    if users_name.nil?
      choices = choices.map do |choice|
        if choice[:name] == "back" 
          choice[:name] = "back"
        else
          choice.merge({disabled: "account required"})
        end
      end
    else
      current_user = User.find_by(username: users_name)
    end
    binding.pry
    prompt = TTY::Prompt.new
    size = prompt.select("What would you like to order?", choices)
    case size
    when choices[0]
      12
    when choices[1]
      16
    when choices[2]
      20
    when choices[3]
      Cli.new.splash
    end

    #dairy option
    dairy_option = prompt.select("What type of milk would you like?", ["Oat Milk", "Soy Milk", "Half and Half", "Almond Milk", "Beef Milk"])

    sweetener = prompt.select("What type of sweetener would you like?", ["Honey", "Agave", "Stevia", "Syrup", "Sugar in the Raw"])
    sweetness = prompt.slider("How sweet would you like your PSL?", min: 1, max: 5)
    iced = prompt.yes?("Would you like your PSL iced?")
    whip = prompt.yes?("Would you like whip cream on your PSL?")
    shots = prompt.slider("How many espresso shots would you like?", min: 1, max: 4)

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
      shots: shots,
      paid?: false
    )
    if prompt.yes?("This will cost $#{temp_psl.cost}. Sound good?")
      temp_psl.update(paid?: true)
      temp_psl.save
      current_user.update(wallet: (current_user.wallet - temp_psl.cost))
    else
      Cli.new.splash
    end
    #put in either rating or refund
  end



end #end of class


