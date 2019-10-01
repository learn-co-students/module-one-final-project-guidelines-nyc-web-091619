class CoffeeShop < ActiveRecord::Base
  has_many :psls
  has_many :users, through: :psls

  def price_point
    if self.cost_per_size >= 0.10 && self.cost_per_size < 0.18
      "$"
    elsif self.cost_per_size >= 0.18 && self.cost_per_size < 0.25
      "$$"
    else
      "$$$"
    end
  end

  def how_good_are_my_psls
    psls_with_ratings = self.psls.select do |psl|
      psl.rating
    end
    psl_rating_array = psls_with_ratings.map do |psl|
      psl.rating.to_f
    end
    psl_rating_sum = psl_rating_array.reduce do |sum, rating|
      sum + rating
    end
    psl_rating_avg = psl_rating_sum / psls_with_ratings.count
    psl_rating_avg.round(1)
  end
end