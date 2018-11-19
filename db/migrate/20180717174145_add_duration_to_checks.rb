class AddDurationToChecks < ActiveRecord::Migration[5.2]
  def change
    add_column :checks, :duration, :string
  end
end
