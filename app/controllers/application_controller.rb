class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  # before_action :authenticate_user!

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

  def after_sign_in_path_for(user)
  end

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) << [:name, :image, :telephone, :description, :remember_me]
    end

end
