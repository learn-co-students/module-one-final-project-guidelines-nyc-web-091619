require 'pry'

class CliApp
    
    def run
        welcome
        user_selection = main_menu_select
        case user_selection
        when "Rent a movie"
            rent_movie
        when "New Member"
            new_member
        when "Check your Membership"
            check_your_membership
        when "Return Movie"
            return_movie
        else 
            puts "Kthxbai"
        end

    end


    def welcome
        puts ""
        puts ""
        puts ""
 puts "        ██████╗██╗     ███████╗██████╗ ██╗  ██╗██████╗ ██╗   ██╗███████╗████████╗███████╗██████╗ "
 puts "        ██╔════╝██║     ██╔════╝██╔══██╗██║ ██╔╝██╔══██╗██║   ██║██╔════╝╚══██╔══╝██╔════╝██╔══██╗"
 puts "        ██║     ██║     █████╗  ██████╔╝█████╔╝ ██████╔╝██║   ██║███████╗   ██║   █████╗  ██████╔╝"
 puts "        ██║     ██║     ██╔══╝  ██╔══██╗██╔═██╗ ██╔══██╗██║   ██║╚════██║   ██║   ██╔══╝  ██╔══██╗"
 puts "        ╚██████╗███████╗███████╗██║  ██║██║  ██╗██████╔╝╚██████╔╝███████║   ██║   ███████╗██║  ██║"
 puts "         ╚═════╝╚══════╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═════╝  ╚═════╝ ╚══════╝   ╚═╝   ╚══════╝╚═╝  ╚═╝ "
 puts ""
 puts ""
        puts "                              Welcome to Clerksbuster."
    end

    def main_menu_select
        prompt = TTY::Prompt.new

        choices = ["Rent a movie", "New Member", "Check your Membership", "Return Movie","Exit"]
        prompt.select("Select option?", choices)
    end

    def rent_movie
        prompt = TTY::Prompt.new
        choices = ["Search by Titles", "View all Movies"]

        movie_selection = prompt.select("Select option?", choices)
        case movie_selection
        when "Search by Titles"
            search_by_title
        else
            view_all_movies
        end
    end

    def check_your_membership
        puts "please enter your name: "
        name = gets.chomp

        Member.all.select(:name, :id, :active).each do |members|
            active = members.active == true ? "Active" : "Inactive"
            if name.downcase == members.name.downcase
                puts "\n Name: #{members.name} \n ID: #{members.id} \n Your membership is #{active}."
            end
        end
    end

    def search_by_title
        prompt = TTY::Prompt.new
        puts "Search movie by title: "
        find_movie = gets.chomp
        if Movie.find_by(name: find_movie)
            puts "Great we have that in stock"
        else
            puts "Sorry we dont have that movie"
            choices = ["Search for another movie?", "Return to Main Menu"]

            post_search_option = prompt.select("Select option?", choices)
            case post_search_option
            when "Search for another movie?"
                search_by_title
            when "Return to Main Menu"
                main_menu_select
            else
                puts "Thats not a valid option!"
            end
        end
    end

    def gets_numbers
        number = gets.chomp
        if number.to_i > 0
            return number
        else
            puts "Thats not a number guy come on be real"
            self.gets_numbers
        end
    end

    
    def new_member
        prompt = TTY::Prompt.new
        puts "Please enter name: " 
        name = gets.chomp
        puts "Please enter age: "
        age = self.gets_numbers
        newmember = Member.create(name: name, age: age, active: true)
        newmember.save
        puts "Welcome to clerksbuster, snootchy bootchies"
    end
    
    def view_all_movies
        puts "ClerksBuster has all these amazing movies"
        puts "========================================="
        print_movies_list
    end
    
    def print_movies_list
        choices = Array.new
        prompt = TTY::Prompt.new
        movie_hash = {} 
        
        check_this = Movie.select(:id, :name, :year, :copies).each do |movie_obj|
            choices << "Name: #{movie_obj.name}. Year: #{movie_obj.year}. Copies: #{movie_obj.copies}"
            movie_hash["Name: #{movie_obj.name}. Year: #{movie_obj.year}. Copies: #{movie_obj.copies}"] = movie_obj
        end
        movie_selection = prompt.select("Select option?", choices.sort, per_page: 30)
        checkout(movie_hash[movie_selection])
    end
    
    
    def checkout(movie)    
        prompt = TTY::Prompt.new
        name = prompt.ask("Thank you for your selection please enter your member credentials: ", required: true)
        if Member.find_by(name: name)
            member = Member.select(:id, :name).select do |members|
                members.name.downcase == name.downcase
            end

            attributes = {
                member_id: member[0].id, 
                movie_id: movie.id, 
                rental_date: DateTime.now.to_date, 
                due_date: DateTime.now.to_date + 3,
                movie_returned: false
            }
            new_rental = Rental.new(attributes)
            new_rental.save
            d = attributes[:due_date]
            puts "Thank you for renting #{movie.name} your movie will be due on #{d}, and your receipt ID is #{new_rental.id}. Please present this ID when returning the movie."
        else
            prompt = TTY::Prompt.new
            puts "You are not in our database, would you like to "
            choices = ["Try again", "Create a new membership?", "Return to main menu?"]

            invalid_credentials = prompt.select("Select option?", choices)
            case invalid_credentials
            when "Try again"
                checkout(movie)
            when "Create a new membership?" 
                new_member
            when "Return to main menu?"
                main_menu_select
            else
                puts "Thats not a valid option!"
            end
        end
    end

    def return_movie
    puts "please enter your receipt ID: "
    receipt = gets.chomp
    binding.pry
    rental_object = Rental.find(receipt)
    rental_object.movie_returned = true
    rental_object.save
    end
    
    def exit(rental=nil)
        if movie==nil
            puts "Thanks for visiting Clerksbuster"
        else
            puts "Thanks for renting at Clerksbuster!  Please enjoy #{rental.movie.name}!  Your movie is due #{movie.rental} Be kind, rewind!"
        end
    end
    
end  # end of CliApp