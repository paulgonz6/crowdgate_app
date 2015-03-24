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
      redirect_to :back
    else
      render 'new'
    end
  end

  def search
    if params[:name].present?
      Rollbar.info("Search for #{params[:name].downcase}")
      @team = Team.find_by("name LIKE '%#{params[:name]}%'")
      if @team.present?
        redirect_to team_url(@team.id)
      else
        flash[:info] = "We're sorry, we currently do not have that team available. The teams that are currently on our platform are listed below."
        redirect_to teams_url
      end
    else
      redirect_to teams_url
    end
  end

  def show
    @events = @team.games
  end

  def index
    @teams = Team.all
  end

  private

    def team_params
      params.require(:team).permit(:headline, :name, :background_image, :color, :sport)
    end

end
