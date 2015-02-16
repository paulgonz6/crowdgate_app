class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  # before_action :authenticate_user!

  def is_user_admin?
    unless current_user.admin?
      redirect_to root_url
      flash[:notice] = "You are not an admin on this site. Access denied."
    end
  end

  # changes redirect_to location for user log_in
  after_filter :store_location
  def store_location
    return unless request.get?
    if (request.path != "/users/sign_in" &&
        request.path != "/users/sign_up" &&
        request.path != "/users/password/new" &&
        request.path != "/users/password/edit" &&
        request.path != "/users/confirmation" &&
        request.path != "/users/sign_out" &&
        !request.xhr?) # don't store ajax calls
      session[:previous_url] = request.fullpath
    end
  end

  def after_sign_in_path_for(resource)
    session[:previous_url] || root_path
  end

  def after_update_path_for(resource)
    session[:previous_url] || root_path
  end

  def after_sign_out_path_for(resource)
    session[:previous_url] || root_path
  end

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) << [:name, :image, :phone, :description, :remember_me]
    end

end
