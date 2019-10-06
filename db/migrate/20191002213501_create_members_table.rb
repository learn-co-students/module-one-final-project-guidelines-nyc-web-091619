class CreateMembersTable < ActiveRecord::Migration[5.2]
  def change
    create_table :members do |t|
      t.string    :name
      t.integer   :age
      t.boolean   :active
    end
  end
end
