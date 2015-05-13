class Team < ActiveRecord::Base
  has_many :home_games, :class_name => "Event", :foreign_key => "home_team_id"
  has_many :away_games, :class_name => "Event", :foreign_key => "away_team_id"
  has_many :home_tailgates, :through => "home_games", :source => "tailgates"
  has_many :away_tailgates, :through => "away_games", :source => "tailgates"

  validates_presence_of :name, :background_image, :color, :sport

  validates :sport,
            inclusion: { in: ["College Football", "College Baseball", "NFL"] }

  scope :college_football,  -> { where(:sport => 'College Football').order(:name) }
  scope :college_baseball,  -> { where(:sport => 'College Baseball').order(:name) }
  scope :nfl,               -> { where(:sport => 'NFL').order(:name) }

  def games
    self.home_games + self.away_games
  end


  def tailgates
    self.home_tailgates + self.away_tailgates
  end

  def total_live_tailgates
    tailgates = []
    games = self.games
    games.each do |game|
      game.tailgates.each do |tailgate|
        if tailgate.current_size > 0 && tailgate.live?
          tailgates << tailgate
        end
      end
    end
    tailgates
  end

end
