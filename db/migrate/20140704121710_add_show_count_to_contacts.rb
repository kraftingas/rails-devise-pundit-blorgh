class AddShowCountToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :show_count, :integer, :default => 0
  end
end