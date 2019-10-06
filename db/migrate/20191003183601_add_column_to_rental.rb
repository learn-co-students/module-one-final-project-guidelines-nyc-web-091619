class AddColumnToRental < ActiveRecord::Migration[5.2]
  def change
    add_column :rentals, :movie_returned, :boolean
  end
end
