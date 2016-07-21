class AddClosedToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :closed, :integer
  end
end
