class AddColumnsToVulnerabilities < ActiveRecord::Migration[5.2]
  def change
    add_column :vulnerabilities, :weakness, :string
    add_column :vulnerabilities, :risk, :string
    add_column :vulnerabilities, :recommandation, :string
  end
end
