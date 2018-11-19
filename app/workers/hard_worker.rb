class HardWorker

  include Sidekiq::Worker

  def perform(check_id)
    CheckService.new(check_id).run
  end

end
