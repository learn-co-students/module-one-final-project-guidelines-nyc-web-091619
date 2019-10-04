class CreateUserTable < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :username
      t.string :name
      t.string :home_location
      t.float :wallet
      t.integer :psl_quota
      t.timestamps
    end
  end
end
