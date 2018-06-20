class RemoveColumnsFromChecks < ActiveRecord::Migration[5.2]
  def change
    remove_column :checks, :version, :string
    remove_column :checks, :reason, :string
    remove_column :checks, :versbosity, :string
  end
end
