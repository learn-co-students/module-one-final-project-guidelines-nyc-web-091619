class CreateUserTable < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :name
      t.string :home_location
      t.string :current_location
      t.float :wallet
      t.integer :psl_quota
    end
  end
end
