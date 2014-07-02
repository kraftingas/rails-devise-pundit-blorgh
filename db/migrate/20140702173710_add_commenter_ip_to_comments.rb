class AddCommenterIpToComments < ActiveRecord::Migration
  def change
    add_column :comments, :commenter_ip, :string
  end
end