class Traveller < ActiveRecord::Base
  has_many :travellerdestinations
  has_many :destinations, through: :travellerdestinations


# new_user = User.new
# new_user.greet
# input = new_user.get_username
# current_user = User.create(‘username’ => input)


  def view_my_list
    my_travels = Travellerdestination.all.select do |td|
      td.traveller == self
    end
    travel.map do |travel|
      travel.destination
    end
  end




end



