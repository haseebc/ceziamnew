class RegistrationsController < Devise::RegistrationsController
    before_action :configure_permitted_parameters, if: :devise_controller?

    protected

    def configure_permitted_parameters
        # For additional fields in app/views/devise/registrations/new.html.erb
        devise_parameter_sanitizer.permit(:sign_up, keys: [:firstname, :lastname, :company])
    
        # For additional in app/views/devise/registrations/edit.html.erb
        devise_parameter_sanitizer.permit(:account_update, keys: [:firstname, :lastname, :company])
      end

    def after_sign_up_path_for(resource)
        if session[:last_check_id]
            check_full_report_path(session[:last_check_id])
        end
    end
end
