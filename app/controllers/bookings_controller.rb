class BookingsController < ApplicationController

  def billing
    @tailgate = Tailgate.find(params[:id])
  end

  def receipt
    @tailgate = Tailgate.find(params[:id])
    @tailgate.size -= params[:quantity].to_i
    @tailgate.save
  end

end
