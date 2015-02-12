class UsersController < ApplicationController

  before_action :authenticate_user!, :only => [:index]
  before_action :is_user_admin?, :only => [:index]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def tailgates_index
    @tailgates = User.find(params[:id]).tailgates
  end

  def become_host_sign_up
    @user = User.new
  end

  private
    def is_user_admin?
      unless current_user.admin?
        redirect_to root_url, :notice => "You do not have access to this page"
      end
    end

end
