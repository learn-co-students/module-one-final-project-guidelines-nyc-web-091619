class Psl < ActiveRecord::Base
  belongs_to :user
  belongs_to :coffee_shop

  def cost
    cost_size = coffee_shop.cost_per_size * self.size

    espresso_addition = self.shots > 1 ? ((coffee_shop.cost_per_size * 3) * self.shots) : 0

    cost_size + espresso_addition
  end
end