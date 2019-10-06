class CreateRentalTables < ActiveRecord::Migration[5.2]
  def change
    create_table :rentals do |t|
      t.integer :member_id
      t.integer :movie_id
      t.datetime :rental_date
      t.datetime :due_date
    end
  end
end
