class AddRatingToPsls < ActiveRecord::Migration[5.2]
  def change
    add_column :psls, :rating, :integer
  end
end
