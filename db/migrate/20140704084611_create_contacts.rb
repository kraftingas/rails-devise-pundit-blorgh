class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.integer :contacting_with_id
      t.string :name
      t.string :email
      t.string :content

      t.timestamps
    end
  end
end
