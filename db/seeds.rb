require 'csv'

coffeehouse = CSV.read("cafedata.csv")
coffeehouse.shift
coffeehouse.each do |row|
  cps = (rand * (0.3 - 0.1) + 0.1).round(2)
  CoffeeShop.create(name: row[1], location: row[2], cost_per_size: cps)
end


