class AddCustomStatusToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :custom_status, :string
  end
end
