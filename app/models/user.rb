require_relative '../../config/environment'

class User < ActiveRecord::Base
    belongs_to :owner
    belongs_to :walker

    def run_owner
        prompt= TTY::Prompt.new

        #identify which owner you are 
        owner = Owner.find_by(user_id: self.id)
        puts "Welcome, #{owner.name}!"

        ####LOOP TILL THEY CHOOSE TO EXIT! ##############
        loop do 
            options = ["See my dogs", "Request a walk", "Rate a walk", "Cancel a walk", "See walks currently in progress", "See Upcoming Walks", "See past walks", "Exit"]
            action = prompt.select("What would you like to do?", options)
            system "clear"

            case action
            when options[0] #see dogs
                owner.see_my_dogs
                # puts "Your doggos:\n"
                # puts pretty_dogs(owner.dogs).join("\n")

            when options[1] #request walk
                owner.request_walk
                # doggo = prompt.select('Which of your dogs needs a walk?', pretty_dogs(owner.dogs))
                # date = prompt.ask("What date? (YYYY-MM-DD)"){|q| q.validate /\d{4}-[0-1][0-2]-[0-3][0-9]\z/, 'Please enter a valid date'}
                # time = prompt.ask("What time? (HH:MM)"){|q| q.validate /[01][0-9]:[0-5][0-9]\z/, 'Please enter a valid time'}
                # ampm = prompt.select('AM or PM?', %w(AM PM))
                # length = prompt.select('How long of a walk (in minutes)?', [30, 60])
                # date_and_time = string_to_datetime(date, time, ampm)

                # owner.request_walk(owner.dogs.find_by_name(doggo), date_and_time, length )
                # puts "Great, your walk for #{doggo} is scheduled for e#{date} at #{time} with #{walk.walker.name}!"

            when options[2] #rate walk
                owner.rate_walk
                # if owner.past_walks != []
                #     response = prompt.select('Which walk would you like to rate?', pretty_walks(owner.past_walks))
                #     rate_walk_id = response.split(/[#:]/)[1].to_i
                #     rate_walk = Walk.find(rate_walk_id)
                #     this_rating = prompt.ask("Great, what would you like to rate this walk? (1-5)"){|q| q.validate /[1-5].?[0-9]?[0-9]?\z/, 'Please enter a valid rating between 1 and 5'}
                #     rate_walk.update(rating: this_rating)
                #     puts "Your walks has been rated!"
                # else
                #     puts "Sorry, you have no past walks to rate!"
                # end
            
            when options[3] #cancel walk
                owner.cancel_walk
                # if owner.upcoming_walks != []
                #     walk_to_cancel = prompt.select("Which of the walks you want to cancel?", pretty_walks(owner.upcoming_walks))
                #     id = walk_to_cancel.split(/[#:]/)[1].to_i
                #     owner.cancel_walk(Walk.find(id))
                #     puts "Great, your walk for #{Walk.find(id).dog.name} was cancelled!"
                # else
                #     puts "Sorry, you don’t have any upcoming walks!!!"
                # end

            when options[4] #see in progress
                owner.walks_in_progress
                # if(owner.walks_in_progress == [])
                #     puts "No walks in progress!"
                # else
                #     puts "In Progress Walks:"
                #     puts pretty_walks(owner.walks_in_progress).split("\n")
                # end

            when options[5] #see upcoming
                puts "Upcoming Walks:"
                puts owner.upcoming_walks
                # if(owner.upcoming_walks == [])
                #     puts "No upcoming walks!"
                # else
                #     puts "Upcoming Walks:"
                #     puts pretty_walks(owner.upcoming_walks).split("\n")
                # end

            when options[6] #see past
                puts "Past Walks:"
                puts owner.past_walks
                # if(owner.past_walks == [])
                #     puts "No past walks!"
                # else
                #     puts "Past Walks:"
                #     puts pretty_walks(owner.past_walks).split("\n")
                # end

            when options[7] #exit
                exit_app
            end

            prompt.ask("Hit enter when done")
            system "clear"
        end
        
    end #END RUN OWNER


    def run_walker
        prompt= TTY::Prompt.new
        
        walker = Walker.find_by(user_id: self.id)
        puts "Welcome, #{walker.name}!"

        loop do 

            options = ["See current walk", "Start a Walk", "End a Walk", "Cancel A Walk", "See Upcoming Walks", "Exit"]
            action = prompt.select("What would you like to do?", options)
            
            case action
            when options[0] #current walk
                walker.current_walk
                # if(walker.walks_in_progress == [])
                #     puts "No walks in progress!"
                # else
                #     puts "In Progress Walks:"
                #     puts pretty_walks(owner.walks_in_progress).split("\n")
                # end
            when options[1] #start walk
                walker.start_walk

            when options[2] #end walk
                walker.finish_walk

            when options[3] #cancel walk
                walker.cancel_walk

            when options[4] #upcoming walks
                walker.upcoming_walks
                
            when options[5] #exit
                exit_app
            end

            prompt.ask("Hit enter when done")
            system "clear"

        end


    end

end


