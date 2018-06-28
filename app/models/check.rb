class Check < ApplicationRecord
  belongs_to :user, required: false
  after_create :run_async_check
  has_many :vulnerabilities

  def set_global_score
    self.score = self.vulnerabilities.pluck(:netrisk).max
    self.save
  end

  def run_async_check
    HardWorker.perform_async(self.id)
  end

  def complete!
    self.state = "completed"
  end

  def completed?
    self.state == "completed"
  end

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


