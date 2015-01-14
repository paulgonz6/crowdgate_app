class TailgatesController < ApplicationController

  def show
    @tailgate = Tailgate.find_by({ :id => params[:id]})
  end


  def index
    @tailgates = Tailgate.all.reverse
  end

  def confirm_purchase
  end

  def new
  end

  def process_form
    new_tailgate = Tailgate.new
    new_tailgate.size = params[:size]
    new_tailgate.name = params[:name]
    new_tailgate.description = params[:description]
    new_tailgate.affiliation = params[:affiliation]
    new_tailgate.price = params[:price]
    new_tailgate.save
    redirect_to('/tailgates/index')
  end

end
