class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update_attributes(user_params)
    redirect_to user_url(@user.id)
  end

  # def create
  #   @user = User.new(user_params)
  #   if @user.save
  #     flash[:success] = "Thank you for signing up!"
  #     redirect_to user_url(@user.id)
  #   else
  #     render 'new'
  #   end
  # end

  def show
    @user = User.find(params[:id])
    @tailgates = User.find(params[:id]).tailgates

    puts @tailgates.count

    @bookings = Booking.where( { :user_id => params[:id]})
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:danger] = "We are sorry to see you go."
    redirect_to('/')
  end

  def tailgates_index
    @tailgates = User.find(params[:id]).tailgates
  end

end
