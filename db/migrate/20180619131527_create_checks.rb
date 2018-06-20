class CreateChecks < ActiveRecord::Migration[5.2]
  def change
    create_table :checks do |t|
      t.string :version
      t.string :ip
      t.string :hostname
      t.string :reason
      t.string :versbosity
      t.string :scandur
      t.integer :score
      t.references :user, foreign_key: true, index: true

      t.timestamps
    end
  end
end
