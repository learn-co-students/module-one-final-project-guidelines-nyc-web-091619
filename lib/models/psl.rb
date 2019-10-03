class Psl < ActiveRecord::Base
  belongs_to :user
  belongs_to :coffee_shop
  # Instance Methods
  def cost
    cost_size = coffee_shop.cost_per_size * self.size

    espresso_addition = self.shots > 1 ? ((coffee_shop.cost_per_size * 3) * self.shots) : 0

    (cost_size + espresso_addition).round(2)
  end

  # Class Methods
  ## Small/medium/large to be used in Cli#display methods for quick cost getting.
  def self.small(coffee_shop)
    Psl.new(size: 12, coffee_shop_id: coffee_shop.id, shots: 1)
  end
  def self.medium(coffee_shop)
    Psl.new(size: 16, coffee_shop_id: coffee_shop.id, shots: 1)
  end
  def self.large(coffee_shop)
    Psl.new(size: 20, coffee_shop_id: coffee_shop.id, shots: 1)
  end
end