class CreateCoffeeShopsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :coffee_shops do |t|
      t.string :name
      t.string :location
      t.datetime :opens_at
      t.datetime :closes_at
      t.float :cost_per_size
      t.timestamps
    end
  end
end
