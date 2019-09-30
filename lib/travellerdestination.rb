class Travellerdestination < ActiveRecord::Base
  belongs_to :travellers
  belongs_to :destinations
end
