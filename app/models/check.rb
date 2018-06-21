class Check < ApplicationRecord
  belongs_to :user
  after_create :set_vulnerabilities, :set_check, :global_score

  has_many :vulnerabilities

  def global_score
    @ports_checked = JSON.parse(self.fullresponse)["nmaprun"]["host"]["ports"]["port"]

    @ports_opened = []

    JSON.parse(self.fullresponse)["nmaprun"]["host"]["ports"]["port"].each do |info|
      if info["state"]["state"] == "open"
        @ports_opened << info["portid"]
      end
    end

    @global_score = (1 - (@ports_opened.count.to_f / @ports_checked.count.to_f)) * 100
  
    return @global_score
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
  end

  def set_check
    self.ip = JSON.parse(self.fullresponse)["nmaprun"]["host"]["address"]["addr"]
    self.scandur = JSON.parse(self.fullresponse)["nmaprun"]["runstats"]["finished"]["elapsed"]
    self.save
  end
end


