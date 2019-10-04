class CreateTravellerTable < ActiveRecord::Migration[5.2]
  def change
    create_table :travellers do |t|
      t.string :name
    end
  end
end
