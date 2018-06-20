class AddColumnsToVulnerabilities < ActiveRecord::Migration[5.2]
  def change
    add_column :vulnerabilities, :version, :string
    add_column :vulnerabilities, :reason, :string
    add_column :vulnerabilities, :product, :string
  end
end
