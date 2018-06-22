class AddColumnsToVulnerabilities < ActiveRecord::Migration[5.2]
  def change
    add_column :vulnerabilities, :version, :string
    add_column :vulnerabilities, :reason, :string
    add_column :vulnerabilities, :product, :string
    add_column :vulnerabilities, :weakness, :string
    add_column :vulnerabilities, :risk, :string
    add_column :vulnerabilities, :recommandation, :string
    add_column :vulnerabilities, :impact, :integer
    add_column :vulnerabilities, :likelihood, :integer
    add_column :vulnerabilities, :netrisk, :integer
  end
end
