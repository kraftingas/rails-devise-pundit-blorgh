class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.belongs_to :post
      t.integer :post_id
      t.text :text

      t.timestamps
    end
  end
end
