class User < ActiveRecord::Base
  has_many :psls
  has_many :coffee_shops, through: :psls

  def shops_in_da_hood
    CoffeeShop.select do |cafe|
      cafe.location == self.home_location
    end
  end

  def affordable
    max_price_per_oz = self.wallet / (self.psl_quota * 12)
    shops_in_da_hood.find do |shop|
      shop.cost_per_size < max_price_per_oz
    end
  end
end