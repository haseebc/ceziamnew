class AddDomcheckDurationToChecks < ActiveRecord::Migration[5.2]
  def change
    add_column :checks, :domcheck_duration, :integer
  end
end
