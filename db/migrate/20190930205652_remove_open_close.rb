class RemoveOpenClose < ActiveRecord::Migration[5.2]
  def change
    remove_column :coffee_shops, :opens_at, :datetime
    remove_column :coffee_shops, :closes_at, :datetime
  end
end
