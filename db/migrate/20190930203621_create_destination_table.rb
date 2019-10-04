class CreateDestinationTable < ActiveRecord::Migration[5.2]
  def change
    create_table :destinations do |t|
      t.string :city
    end
  end
end
