class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :deny_banned

  protected

  
    def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
    devise_parameter_sanitizer.for(:sign_in) << :name
    devise_parameter_sanitizer.for(:account_update) << :name

    devise_parameter_sanitizer.for(:sign_up) << :date_of_birth
    devise_parameter_sanitizer.for(:sign_in) << :date_of_birth
    devise_parameter_sanitizer.for(:account_update) << :date_of_birth

    devise_parameter_sanitizer.for(:sign_up) << :image
    devise_parameter_sanitizer.for(:sign_in) << :image
    devise_parameter_sanitizer.for(:account_update) << :image
    
    devise_parameter_sanitizer.for(:sign_up) << :address
    devise_parameter_sanitizer.for(:sign_in) << :address
    devise_parameter_sanitizer.for(:account_update) << :address

    devise_parameter_sanitizer.for(:sign_up) << :phone
    devise_parameter_sanitizer.for(:sign_in) << :phone
    devise_parameter_sanitizer.for(:account_update) << :phone

    devise_parameter_sanitizer.for(:sign_up) << :admin
    devise_parameter_sanitizer.for(:sign_in) << :admin
    devise_parameter_sanitizer.for(:account_update) << :admin
    
    devise_parameter_sanitizer.for(:sign_up) << :banned
    devise_parameter_sanitizer.for(:sign_in) << :banned
    devise_parameter_sanitizer.for(:account_update) << :banned

    devise_parameter_sanitizer.for(:sign_up) << :joining_date
    devise_parameter_sanitizer.for(:sign_in) << :joining_date
    devise_parameter_sanitizer.for(:account_update) << :joining_date

    devise_parameter_sanitizer.for(:sign_up) << :manager_email
    devise_parameter_sanitizer.for(:sign_in) << :manager_email
    devise_parameter_sanitizer.for(:account_update) << :manager_email
  end

def deny_banned
  if !current_user.nil? && current_user.banned?
    #redirect_to destroy_user_session_path
    sign_out current_user
    redirect_to root_path, :notice => "You are banned from this site."
  end

end
  
end
