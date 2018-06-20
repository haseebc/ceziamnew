class CreateVulnerabilities < ActiveRecord::Migration[5.2]
  def change
    create_table :vulnerabilities do |t|
      t.string :port
      t.string :protocol
      t.string :state
      t.string :service
      t.references :check, foreign_key: true, index: true

      t.timestamps
    end
  end
end
