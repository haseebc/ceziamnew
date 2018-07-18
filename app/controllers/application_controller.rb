class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: [:firstname, :lastname, :company])

    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: [:firstname, :lastname, :company])
  end

  def after_sign_in_path_for(resource)
    if session[:last_check_id]
      check = Check.find(session[:last_check_id])
      check.user = resource
      check.save
    end
    dashboard_profile_path(resource)
    # request.env['omniauth.origin'] || stored_location_for(resource) || root_path
  end
end
