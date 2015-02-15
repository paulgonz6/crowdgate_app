class TeamsController < ApplicationController

  # before_action :is_user_admin?, :only => [:new, :create, :update, :destroy, :edit]
  before_action :authenticate_user!, :only => [:new, :create, :update, :edit, :destroy]
  before_action :is_user_admin?, :only => [:new, :create, :update, :edit, :destroy]
  before_action :find_team, :only => [:show]

  def find_team
    @team = Team.find(params[:id])
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.new(team_params)
    if @team.save
      flash[:success] = "You have just added #{@team.name}"
      redirect_to teams_url
    else
      render 'new'
    end
  end

  def search
    if params[:name].present?
      @team = Team.find_by("name LIKE '%#{params[:name]}%'")
      redirect_to team_url(@team.id)
    else
      redirect_to teams_url
    end
  end

  def show
    @events = Event.where("name LIKE '%#{@team.name}%'").order("date ASC")
  end

  def index
    @teams = Team.all
  end

  private

    def team_params
      params.require(:team).permit(:headline, :name, :background_image, :color)
    end

end
