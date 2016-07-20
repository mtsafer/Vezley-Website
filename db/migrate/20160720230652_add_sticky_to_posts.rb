class AddStickyToPosts < ActiveRecord::Migration[5.0]
  def change
  	add_column :posts, :sticky, :integer
  end
end
