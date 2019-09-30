class CreateCoffeeShopsTable < ActiveRecord::Migration[6.0]
  def change
    create_table :coffee_shops do |t|
      t.string :name
      t.string :location
      t.datetime :opens_at
      t.datetime :closes_at
      t.float :cost_per_size
    end
  end
end
