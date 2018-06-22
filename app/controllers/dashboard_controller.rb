class DashboardController < ApplicationController
    def checks
        @checks = current_user.checks
    end

    def detailed_results
        @check = Check.last
        @check.user = current_user
        @check.save
    end
end
