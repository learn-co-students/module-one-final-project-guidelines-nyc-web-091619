require 'csv'
require "faker"

#User Data
boros = ["Queens", "Bronx", "Manhattan", "Brooklyn", "Staten Island"]
100.times do
  name = Faker::Name.unique.name
  username = name.sub(" ","")
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


