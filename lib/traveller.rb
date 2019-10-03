class Traveller < ActiveRecord::Base
  has_many :travellerdestinations
  has_many :destinations, through: :travellerdestinations


# new_user = User.new
# new_user.greet
# input = new_user.get_username
# current_user = User.create(‘username’ => input)


  # def view_my_list
  #   my_travels = Travellerdestination.all.select do |td|
  #     td.traveller == self
  #   end
  #   travel.map do |travel|
  #     travel.destination
  #   end
  # end

  # def view_all_my_destinations

  # end

  def add_trip(dest)
    Travellerdestination.create(traveller_id: self.id, destination_id: dest.id)
  end

  # def my_trips
  #   Travellerdestination.
  # end



  def update_dates
  end


  def cancel_my_trip
  end

end



