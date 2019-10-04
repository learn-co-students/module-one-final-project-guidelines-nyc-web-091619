class CreateTravellerdestinationTable < ActiveRecord::Migration[5.2]
  def change
    create_table :travellerdestinations do |t|
      t.integer :traveller_id
      t.integer :destination_id
      t.string :checkin
    end
  end
end
