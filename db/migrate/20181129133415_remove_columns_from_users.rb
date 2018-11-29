class RemoveColumnsFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :provider
    remove_column :users, :uid
    remove_column :users, :facebook_picture_url
    remove_column :users, :first_name
    remove_column :users, :last_name
    remove_column :users, :token
    remove_column :users, :token_expiry
  end
end
