class CreateViewings < ActiveRecord::Migration[5.0]
  def change
    create_table :viewings do |t|
      t.integer :user_id
      t.integer :post_id
      t.datetime :viewed_at

      t.timestamps
    end
  end
end
