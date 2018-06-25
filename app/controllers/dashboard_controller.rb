class DashboardController < ApplicationController
    def checks
        @checks = current_user.checks
    end
end
