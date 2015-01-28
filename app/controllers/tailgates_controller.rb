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
      flash[:success] = "Successfully created tailgate for #{@tailgate.event.name}."
      redirect_to user_url(@tailgate.user_id)
    else
      render('tailgates/new')
    end

  end

  def index
    if params[:search].present?
      @events = Event.where("name LIKE '%#{params[:search]}%'").order(:date)
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
    @tailgate.size =                    params[:tailgate]["size"]
    @tailgate.name =                    params[:tailgate]["name"]
    @tailgate.description =             params[:tailgate]["description"]
    @tailgate.affiliation =             params[:tailgate]["affiliation"]
    @tailgate.price =                   params[:tailgate]["price"]
    @tailgate.grill =                   params[:tailgate]["grill"]
    @tailgate.tent =                    params[:tailgate]["tent"]
    @tailgate.table =                   params[:tailgate]["table"]
    @tailgate.chairs =                  params[:tailgate]["chairs"]
    @tailgate.reserved_parking =        params[:tailgate]["reserved_parking"]
    @tailgate.bevs_alcohol =            params[:tailgate]["bevs_alcohol"]
    @tailgate.bevs_non_alcohol =        params[:tailgate]["bevs_non_alcohol"]
    @tailgate.food =                    params[:tailgate]["food"]
    @tailgate.event_id =                params[:tailgate]["event_id"]
    @tailgate.tailgate_start_time =     params[:tailgate]["tailgate_start_time"]
    @tailgate.tailgate_during_game =    params[:tailgate]["tailgate_during_game"]
    @tailgate.user_id =                 params[:tailgate]["user_id"]
    @tailgate.image_1 =                 params[:tailgate]["image_1"]
    @tailgate.image_2 =                 params[:tailgate]["image_2"]
    @tailgate.image_3 =                 params[:tailgate]["image_3"]
    @tailgate.image_4 =                 params[:tailgate]["image_4"]

    if @tailgate.save
      flash[:success] = "Successfully updated your tailgate for #{@tailgate.event.name}."
      redirect_to user_url(@tailgate.user_id)
    else
      render('tailgates/edit')
    end
  end

  def confirm_purchase
  end

  def destroy
    t = Tailgate.find(params[:id])
    t.destroy

    flash[:danger] = "You have successfully deleted #{t.name}"
    redirect_to user_url(t.user_id)
  end

end
