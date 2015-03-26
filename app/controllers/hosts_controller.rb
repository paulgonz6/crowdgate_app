class HostsController < ApplicationController

  def new
  end

  def create
    @email = params[:email]
    BecomeHostMailer.become_host(@email).deliver_now
    BecomeHostMailer.schedule_appointment(@email).deliver_now

    respond_to do |format|
      format.js
    end
  end

end
