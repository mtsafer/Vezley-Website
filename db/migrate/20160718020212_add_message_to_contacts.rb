class AddMessageToContacts < ActiveRecord::Migration[5.0]
  def change
    add_column :contacts, :message, :text
  end
end
