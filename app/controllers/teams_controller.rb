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

  def team_request
    gb = Gibbon::API.new(ENV['mail_chimp_api'])
    gb.lists.subscribe( {:id => ENV['mail_chimp_teams_list'],
                        :email => {:email => params[:email]},
                        :merge_vars => {:TEAMNAME => params[:team_name]},
                        :double_optin => false}
                      )
    respond_to do |format|
      format.js
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
      params.require(:team).permit(:headline, :name, :background_image, :color, :sport)
    end

end
