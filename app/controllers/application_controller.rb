class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
     attributes = [:profile_image_cache_id, :profile_image, :first_name, :middle_name, :last_name, :email, :password, :password_confirmation]
     devise_parameter_sanitizer.permit(:sign_up, keys: attributes)
     devise_parameter_sanitizer.permit(:account_update, keys: attributes)

  end
end
