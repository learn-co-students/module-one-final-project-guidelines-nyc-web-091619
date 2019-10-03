class Restaurant < ActiveRecord::Base
    has_many :favorites
    has_many :users, through: :favorites 

    
    def self.all_names 
            self.all.map do |restaurant|
                restaurant.name 
            end 
        end 

     def self.return_random_restaurant
       a = Restaurant.all.sample 
       puts a.name 
       puts a.location
      end 
    
    
    #     def return_random_restaurant
    #         puts all_restaurant_names.sample
    #       end 
    
        

end