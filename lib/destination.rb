class Destination < ActiveRecord::Base
  has_many :travellerdestinations
  has_many :travellers, through: :travellerdestinations
end
