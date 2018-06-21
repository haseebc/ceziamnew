class DashboardController < ApplicationController
    def checks
        @checks = current_user.checks
    end

    def detailed_results
        @check = current_user.checks.last
    end
end
