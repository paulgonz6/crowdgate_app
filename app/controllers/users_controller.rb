class UsersController < ApplicationController

  before_action :authenticate_user!, :only => [:index]
  before_action :is_user_admin?, :only => [:index]
  before_action :is_user_owner?, :only => [:show]

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

    def is_user_owner?
      unless current_user == User.find(params[:id])
        redirect_to root_url
        flash[:notice] = "That's not yours. Sorry."
      end
    end

end
