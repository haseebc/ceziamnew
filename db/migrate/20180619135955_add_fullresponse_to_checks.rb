class AddFullresponseToChecks < ActiveRecord::Migration[5.2]
  def change
    add_column :checks, :fullresponse, :jsonb
  end
end
