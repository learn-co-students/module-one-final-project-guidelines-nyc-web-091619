class Restaurant < ActiveRecord::Base
    has_many :favorites
    has_many :users, through: :favorites 

    
    # def self.all_restaurant_names 
    #         restaurant_names = Restaurant.all.map do |restaurant|
    #             restaurant.name 
    #         end 
    #     end 
    
    
    #     def return_random_restaurant
    #         puts all_restaurant_names.sample
    #       end 
    
        

end