class User < ActiveRecord::Base
    has_many :favorites
    has_many :restaurants, through: :favorites 


    
    
end 