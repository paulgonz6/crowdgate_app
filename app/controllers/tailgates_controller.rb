class TailgatesController < ApplicationController

  def show
    @tailgate = Tailgate.find_by({ :id => params[:id]})
    puts @tailgate.table?
    puts @tailgate.description
    puts "Hello"
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

    new_tailgate.grill = params[:grill]
    new_tailgate.tent = params[:tent]
    new_tailgate.table = params[:table]
    new_tailgate.chairs = params[:chairs]
    new_tailgate.reserved_parking = params[:reserved_parking]
    new_tailgate.bevs_alcohol = params[:bevs_alcohol]
    new_tailgate.bevs_non_alcohol = params[:bevs_non_alcohol]
    new_tailgate.food = params[:food]

    new_tailgate.save
    redirect_to('/tailgates/index')
  end

end
