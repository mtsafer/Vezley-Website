class CreateInfoBlocks < ActiveRecord::Migration[5.0]
  def change
    create_table :info_blocks do |t|
      t.string :title
      t.text :body
      t.string :name

      t.timestamps
    end
  end
end
