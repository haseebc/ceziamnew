class AddColumnsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :firstname, :string
    add_column :users, :lastname, :string
    add_column :users, :company, :string
    add_column :users, :profilepicture, :string
    add_column :users, :nochecks, :integer
  end
end
