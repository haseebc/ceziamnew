class RegistrationsController < Devise::RegistrationsController
    protected

    def after_sign_up_path_for(resource)
        if session[:last_check_id]
            check_full_report_path(session[:last_check_id])
        end
    end
end
