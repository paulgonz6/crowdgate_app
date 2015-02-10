class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @tailgates = User.find(params[:id]).tailgates

    puts @tailgates.count

    @bookings = Booking.where( { :user_id => params[:id]})
  end

  def tailgates_index
    @tailgates = User.find(params[:id]).tailgates
  end

  def become_host_sign_up
    @user = User.new
  end

end
