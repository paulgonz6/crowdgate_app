class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Thank you for signing up!"
      redirect_to user_url(@user.id)
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def tailgates_index
    @tailgates = User.find(params[:id]).tailgates
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :image)
    end

end
