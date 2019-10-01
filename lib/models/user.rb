class User < ActiveRecord::Base
  has_many :psls
  has_many :coffee_shops, through: :psls

  def shops_in_da_hood
    CoffeeShop.select do |cafe|
      cafe.location == self.home_location
    end
  end

  def couple_of_nearby_shops
    shops_in_da_hood.first(10)
  end

  def affordable
    max_price_per_oz = self.wallet / (self.psl_quota * 12)
    affordable_shop = shops_in_da_hood.select do |shop|
      shop.cost_per_size < max_price_per_oz
    end.sample

    affordable_shop.nil? ? "You'll never reach your quota if you don't deposit some funds" : affordable_shop

  end

end