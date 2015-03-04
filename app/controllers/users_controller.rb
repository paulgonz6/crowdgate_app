class UsersController < ApplicationController
  before_action :authenticate_user!, :only => [:index, :account]
  before_action :is_user_admin?, :only => [:index]

  def find_user
    @user = User.find(params[:id])
  end

  def index
    @users = User.all
  end

  def account
  end

end
