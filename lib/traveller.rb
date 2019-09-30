class Traveller < ActiveRecord::Base
  has_many :travellerdestinations
  has_many :destinations, through: :travellerdestinations

end

