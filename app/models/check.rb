class Check < ApplicationRecord

  belongs_to :user, required: false
  after_create :run_async_check
  has_many :vulnerabilities

  def set_global_score
    self.score = vulnerabilities.pluck(:netrisk).max
    save
  end

  def run_async_check
    HardWorker.perform_async(id)
  end

  def complete!
    self.state = 'completed'
  end

  def completed?
    state == 'completed'
  end

  def set_vulnerabilities
    JSON.parse(fullresponse)['nmaprun']['host']['ports']['port'].each do |info|
      next unless info['state']['state'] == 'open'

      Vulnerability.create!(port: info['portid'],
                            state: info['state']['state'],
                            service: info['service']['name'],
                            protocol: info['protocol'],
                            reason: info['state']['reason'],
                            check_id: id)
    end
    set_global_score
  end

  def set_check
    self.ip = JSON.parse(fullresponse)['nmaprun']['host']['address']['addr']
    self.scandur = JSON.parse(fullresponse)['nmaprun']['runstats']['finished']['elapsed']
    save
  end

end
