class AddColorsToInfoBlock < ActiveRecord::Migration[5.0]
  def change
    add_column :info_blocks, :title_color, :string
    add_column :info_blocks, :body_color, :string
  end
end
