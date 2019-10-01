class User < ActiveRecord::Base
  has_many :psls
  has_many :coffee_shops, through: :psls
end