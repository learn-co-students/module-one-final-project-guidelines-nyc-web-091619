class Traveller < ActiveRecord::Base
  has_many :travellerdestinations
  has_many :destinations, through: :travellerdestinations
  
  def add_trip(destination)
      Travellerdestination.create(traveller_id: self.id, destination_id: destination.id)
  end
end
