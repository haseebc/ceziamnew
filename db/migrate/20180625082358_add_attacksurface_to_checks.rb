class AddAttacksurfaceToChecks < ActiveRecord::Migration[5.2]
  def change
    add_column :checks, :attacksurface, :jsonb
  end
end
