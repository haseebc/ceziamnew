class AddStateToChecks < ActiveRecord::Migration[5.2]
  def change
    add_column :checks, :state, :string, default: "pending"
  end
end
