class CoffeeShop < ActiveRecord::Base
  has_many :psls
  has_many :customers, through: :psls
end