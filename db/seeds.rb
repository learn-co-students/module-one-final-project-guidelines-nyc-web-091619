require 'csv'
require 'faker'

#User Data
boros = ["Queens", "Bronx", "Manhattan", "Brooklyn", "Staten Island"]
100.times do
  name = Faker::Name.unique.name
  username = name.gsub(" ","")
  boro = boros.sample
  dollaz = (rand * (20 - 5) + 5).round(2)
  caffeine_intake = (rand(5) + 1)

  User.create(name: name, username: username, home_location: boro, wallet: dollaz, psl_quota: caffeine_intake)
  
end

#CoffeeShop data
coffeehouse = CSV.read("cafedata.csv")
coffeehouse.shift
coffeehouse.each do |row|
  cps = (rand * (0.3 - 0.1) + 0.1).round(2)
  CoffeeShop.create(name: row[1], location: row[2], cost_per_size: cps)
end


#PSL data
dairy = ["Oat Milk", "Soy Milk", "Half and Half", "Almond Milk"]
sweetness = ["honey", "Agave", "Stevia", "Syrup", "Sugar in the Raw"]
tf = [true, false]
size = [12, 16, 20]

10000.times do 
  shop = CoffeeShop.all.sample.id
  customer = User.all.sample.id
  moo = dairy.sample
  sugarsugar = sweetness.sample
  bullzeye = (rand(4) + 1)
  sml = size.sample

  Psl.create(        
    coffee_shop_id: shop,
    user_id: customer,
    dairy_opt: moo,
    sweetener: sugarsugar,
    sweetness: (rand(5) + 1),
    iced?: tf.sample,
    whip?: tf.sample,
    shots: bullzeye,
    size: sml,
    paid?: true,
    rating: (rand(5) + 1)
  )

end


