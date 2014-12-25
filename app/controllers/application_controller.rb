class ApplicationController < ActionController::Base

layout :layout_by_resource  

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  protected

  def layout_by_resource
    if devise_controller?
      "login"
    else
      "application"
    end
  end

  def configure_permitted_parameters
	  devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:employee_id, :email, :password,:first_name,:last_name, :password_confirmation,:sign_up_code) }
	  devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:employee_id, :password) }
  end



end
