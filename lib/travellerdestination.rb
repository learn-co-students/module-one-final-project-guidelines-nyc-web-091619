class Travellerdestination < ActiveRecord::Base
  belongs_to :traveller
  belongs_to :destination
end
