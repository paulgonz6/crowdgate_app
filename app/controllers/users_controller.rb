class UsersController < ApplicationController

  before_action :authenticate_user!, :only => [:index]
  before_action :is_user_admin?, :only => [:index]
  before_action :is_user_owner?, :only => [:show]
  before_action :find_user, :only => [:show, :tailgates_index]

  def find_user
    @user = User.find(params[:id])
  end

  def index
    @users = User.all
  end

  def show
  end

  def tailgates_index
    @tailgates = @user.tailgates
  end

  def become_host_sign_up
    @user = User.new
  end

  private
    def is_user_owner?
      unless current_user == User.find(params[:id])
        redirect_to root_url
        flash[:notice] = "That's not yours. Sorry."
      end
    end

end
