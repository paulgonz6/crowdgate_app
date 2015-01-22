class UsersController < ApplicationController

  def new
  end

  def show
    @user = User.find(params[:id])
  end

  def tailgates_index
    @tailgates = User.find(params[:id]).tailgates
  end

end
