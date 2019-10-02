
class CliApp
  
    def run  
        puts create_table
        # welcome_prompt 
        # set_current_user
        # system "clear"
        # list_of_options
    end 
   

    def list_of_options
        system "clear"
        prompt = TTY::Prompt.new
        puts "Welcome #{@current_user.name}!".center(30)
        user_input = prompt.select("How would you like to proceed", ["1. Find a restaurant's Cleanliness Grade", "2. Add a new favorite restaurant","3. Delete a restaurant from your list", "4. View Your Favorites List", "5. Where should I eat?" ,"6. Exit"])
        system "clear"
        case user_input 

            when "1. Find a restaurant's Cleanliness Grade"
                system "clear"
                get_restaurant_grade
                return_to_main_menu 
                
               
            when 
                "2. Add a new favorite restaurant"
                system "clear"
                add_to_favorite_restaurant
                return_to_main_menu
               

            when "3. Delete a restaurant from your list"
                system "clear"
                delete_a_restaurant_from_favorites
                return_to_main_menu
              
    
            when "4. View Your Favorites List"
                system "clear"
                puts current_user_faves_to_list
                return_to_main_menu

            when "5. Where should I eat?"
                system "clear"
                return_random_restaurant
                return_to_main_menu
            
            when "6. Exit"
                exit 
        
            end 

    end 

    def all_restaurant_names 
        restaurant_names = Restaurant.all.map do |restaurant|
            restaurant.name 
        end 
    end 

    
    def get_restaurant_grade
        prompt = TTY::Prompt.new
        user_input = prompt.select("Please select the restaurant of your choice", all_restaurant_names)
        system "clear"
        puts Restaurant.find_by(name: user_input).grade
    end 

    
    def add_to_favorite_restaurant
        prompt = TTY::Prompt.new
        user_input = prompt.select("Please select the restaurant to add", all_restaurant_names)
        
        restaurant_id= Restaurant.find_by(name: user_input).id 

        if Favorite.find_by(restaurant_id: restaurant_id, user_id: @current_user.id)
            puts "This restaurant already exists in your list"
        else 
            Favorite.create(restaurant_id: restaurant_id, user_id: @current_user.id)
            puts "This restaurant has been added to your list"
        end 
    end

    def delete_a_restaurant_from_favorites  
        prompt = TTY::Prompt.new
        user_input = prompt.select("Please select a restaurant to delete", current_user_faves)
        restaurant_id=  Restaurant.find_by(name: user_input).id
        Favorite.delete_by(restaurant_id: restaurant_id, user_id: @current_user.id)
        puts "Deleted!"
        
    end 

    def return_random_restaurant
      puts all_restaurant_names.sample
    end 
        

    def current_user_faves
        @current_user.restaurants.map do |restaurant|
            restaurant.name 
        end 
    end 

    def current_user_faves_to_list 
         @current_user.restaurants.map.with_index(1) do|restaurant, i|
            "#{i}. #{restaurant.name}"
         end 
     end 


    def return_to_main_menu 
        puts "Would you like to return to the main menu? (Yes/No)"
        user_input = gets.chomp
        if user_input == "Yes"
            list_of_options
        else
              exit 
        end 
    end 

    def welcome_prompt 
        system "clear"
        puts welcome_image
        puts "Welcome to Restaurant Genie!".center(70)
        puts "Please enter your name to continue".center(70)
    end
 

    def set_current_user 
        user_name = gets.chomp  
        @current_user = User.find_or_create_by(name: user_name) 
    end 




end #end of class







