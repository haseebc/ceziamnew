class DashboardController < ApplicationController

  def profile
    @checks = current_user.checks
  end

end
