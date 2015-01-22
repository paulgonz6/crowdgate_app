class TailgatesController < ApplicationController

  def new
    @events = Event.all
    @tailgate = Tailgate.new
  end

  def create
    @events = Event.all

    @tailgate = Tailgate.new
    @tailgate.size = params[:size]
    @tailgate.name = params[:name]
    @tailgate.description = params[:description]
    @tailgate.affiliation = params[:affiliation]
    @tailgate.price = params[:price]
    @tailgate.grill = params[:grill]
    @tailgate.tent = params[:tent]
    @tailgate.table = params[:table]
    @tailgate.chairs = params[:chairs]
    @tailgate.reserved_parking = params[:reserved_parking]
    @tailgate.bevs_alcohol = params[:bevs_alcohol]
    @tailgate.bevs_non_alcohol = params[:bevs_non_alcohol]
    @tailgate.food = params[:food]
    @tailgate.event_id = params[:event_id]
    @tailgate.tailgate_start_time = params[:tailgate_start_time]
    @tailgate.tailgate_during_game = params[:tailgate_during_game]
    @tailgate.user_id = params[:user_id]
    @tailgate.image_1 = params[:image_1]
    @tailgate.image_2 = params[:image_2]
    @tailgate.image_3 = params[:image_3]
    @tailgate.image_4 = params[:image_4]

    if @tailgate.save
      redirect_to "/users/#{@tailgate.user_id}/tailgates", :notice => "Successfully created tailgate for #{@tailgate.event.name}."
    else
      render('tailgates/new')
    end

  end

  def index
    if params[:search].present?
      @events = Event.where("name LIKE '%#{params[:search]}%'")
    else
      @events = []
    end
  end

  def show
    @tailgate = Tailgate.find(params[:id])
  end

  def edit
    @tailgate = Tailgate.find(params[:id])
  end

  def update
    @tailgate = Tailgate.find(params[:id])

    puts @tailgate.name
    puts @tailgate.event_id
    puts @tailgate.event.name

    @tailgate.size = params[:size]
    @tailgate.name = params[:name]
    @tailgate.description = params[:description]
    @tailgate.affiliation = params[:affiliation]
    @tailgate.price = params[:price]
    @tailgate.grill = params[:grill]
    @tailgate.tent = params[:tent]
    @tailgate.table = params[:table]
    @tailgate.chairs = params[:chairs]
    @tailgate.reserved_parking = params[:reserved_parking]
    @tailgate.bevs_alcohol = params[:bevs_alcohol]
    @tailgate.bevs_non_alcohol = params[:bevs_non_alcohol]
    @tailgate.food = params[:food]
    @tailgate.event_id = params[:event_id]
    @tailgate.tailgate_start_time = params[:tailgate_start_time]
    @tailgate.tailgate_during_game = params[:tailgate_during_game]
    @tailgate.user_id = params[:user_id]
    @tailgate.image_1 = params[:image_1]
    @tailgate.image_2 = params[:image_2]
    @tailgate.image_3 = params[:image_3]
    @tailgate.image_4 = params[:image_4]

    if @tailgate.save
      redirect_to "/users/#{@tailgate.user_id}/tailgates", :notice => "Successfully updated tailgate for #{@tailgate.event.name}."
    else
      render('tailgates/edit')
    end
  end

  def confirm_purchase
  end

  def destroy
    t = Tailgate.find(params[:id])
    t.destroy

    redirect_to("/users/#{t.user_id}/tailgates")
  end


end
