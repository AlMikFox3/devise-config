class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?

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
    
  end
  
end
