class AddSenderIdToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :sender_id, :integer
  end
end