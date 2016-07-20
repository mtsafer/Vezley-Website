class AddOwnerAndModToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :mod, :integer
    add_column :users, :owner, :integer
  end
end
