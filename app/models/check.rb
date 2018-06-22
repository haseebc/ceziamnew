class Check < ApplicationRecord
  belongs_to :user, required: false
  after_create :set_vulnerabilities, :set_check

  has_many :vulnerabilities

  def set_global_score
    self.score = self.vulnerabilities.pluck(:netrisk).max
    self.save
  end

  private

  def set_vulnerabilities
    JSON.parse(self.fullresponse)["nmaprun"]["host"]["ports"]["port"].each do |info|
      if info["state"]["state"] == "open"
        Vulnerability.create!(port: info["portid"],
          state: info["state"]["state"],
          service: info["service"]["name"],
          protocol: info["protocol"],
          reason: info["state"]["reason"],
          check_id: self.id)
      end
    end
    set_global_score
  end

  def set_check
    self.ip = JSON.parse(self.fullresponse)["nmaprun"]["host"]["address"]["addr"]
    self.scandur = JSON.parse(self.fullresponse)["nmaprun"]["runstats"]["finished"]["elapsed"]
    self.save
  end
end


