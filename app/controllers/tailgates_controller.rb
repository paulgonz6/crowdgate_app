class TailgatesController < ApplicationController

  def new
    @events = Event.all
    @tailgate = Tailgate.new
  end

  def create
    @events = Event.all
    @tailgate = Tailgate.new(tailgate_params)
    @tailgate.user_id = current_user.id

    if @tailgate.save
      flash[:success] = "Successfully created tailgate for #{@tailgate.event.name}."
      redirect_to @tailgate
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
    @reviews = Review.where({ :tailgate_id => (Tailgate.where({ :user_id => @tailgate.user_id }).pluck(:id)) })
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

  private

    def tailgate_params
      params.require(:tailgate).permit( :size, :name, :description, :affiliation, :price,
                                        :grill, :tent, :table, :chairs, :reserved_parking,
                                        :bevs_alcohol, :bevs_non_alcohol, :food, :event_id,
                                        :tailgate_start_time, :tailgate_during_game, :user_id,
                                        :image_1, :image_2, :image_3, :image_4)

    end

end
