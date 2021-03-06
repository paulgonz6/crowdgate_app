class TailgatesController < ApplicationController
  before_action :authenticate_user!, :only => [:new, :create, :edit, :update, :destroy]
  before_action :is_user_host?, :only => [:new, :create, :edit, :update, :destroy]
  before_action :set_tailgate, :only => [:show, :edit, :update, :destroy]
  before_action :set_type

  def new
    @events = Event.all
    @tailgate = type_class.new
  end

  def create
    @tailgate = type_class.new(tailgate_params)
    @tailgate.host_id = current_user.id

    if @tailgate.class == PackagedTailgate
      @tailgate.original_size = 1
    end

    @tailgate.current_size = @tailgate.original_size

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
    unless @tailgate.live?
      flash[:warning] = "That tailgate is no longer live, sorry about that!"
      redirect_to team_url(@tailgate.event.home_team_id)
    end
  end

  def edit
  end

  def update
    @tailgate.update_attributes(tailgate_params)

    if @tailgate.save
      flash[:success] = "Successfully updated your tailgate for #{@tailgate.event.name}."
      redirect_to account_url
    else
      render('tailgates/edit')
    end
  end

  def destroy
    @tailgate.destroy

    flash[:danger] = "You have successfully deleted #{@tailgate.name}"
    redirect_to account_url
  end

  private

    def set_tailgate
      @tailgate = Tailgate.find(params[:id])
    end

    def is_user_host?
      unless current_user.host_status?
        flash[:warning] = "Sorry, you are not a host. But you can sign up now."
        redirect_to new_host_url
      end
    end

    def tailgate_params
      params.require(@type.underscore).permit(  :original_size, :current_size, :name, :description,
                                                :affiliation, :price, :grill, :tent, :table,
                                                :chairs, :reserved_parking, :bevs_alcohol,
                                                :bevs_non_alcohol, :tailgate_games, :food,
                                                :event_id, :tailgate_start_time,
                                                :tailgate_during_game, :user_id,
                                                :image_1, :image_2, :image_3, :image_4)
    end

    def set_type
      @type = type
    end

    def type
      if Tailgate.types.include?(params[:type])
        params[:type]
      else
        "Tailgate"
      end
    end

    def type_class
      type.constantize
    end


end
