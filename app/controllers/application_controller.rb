class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # before_action :authenticate_user!

  before_filter :update_sanitized_params, if: :devise_controller?

  def update_sanitized_params
    devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:name, :email, :password, :image, :password_confirmation)}
  end

  def user_present?
    unless current_user.present?
      redirect_to root_url
      flash[:notice] = "Please log in to access this page"
    end
  end

  def is_user_admin?
    unless current_user.admin?
      redirect_to root_url
      flash[:notice] = "You are not an administrator on this site. Access denied."
    end
  end

end
