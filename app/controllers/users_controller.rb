class UsersController < ApplicationController
  before_action :authenticate_user!, :only => [:index, :account]
  before_action :is_user_admin?, :only => [:index]
  before_action :find_user, :only => [:edit, :show]

  def index
    @users = User.all
  end

  def account
  end

  def show
    @tailgates = @user.tailgates.live_tailgates
    @reviews = @user.reviews_as_host
  end

  def edit
  end

  def find_user
    @user = User.find(params[:id])
  end

end
