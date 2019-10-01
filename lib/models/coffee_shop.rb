class CoffeeShop < ActiveRecord::Base
  has_many :psls
  has_many :users, through: :psls
end