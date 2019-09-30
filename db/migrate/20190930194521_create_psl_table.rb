class CreatePslTable < ActiveRecord::Migration[6.0]
  def change
    create_table :psl do |t|
      t.integer :coffee_shop_id
      t.integer :user_id
      t.string :dairy_opt
      t.string :sweetener
      t.integer :sweetness
      t.boolean :iced?
      t.boolean :whip?
      t.integer :shots
      t.integer :size
    end
  end
end
