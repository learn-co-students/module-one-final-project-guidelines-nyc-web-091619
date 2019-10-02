class Favorite < ActiveRecord::Base
    belongs_to  :restaurant
    belongs_to  :user

    def self.delete_by(restaurant_id: restaurant_id, user_id: user_id)
        Favorite.find_by(restaurant_id: restaurant_id, user_id: user_id).destroy
    end 


end