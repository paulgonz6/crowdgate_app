class Team < ActiveRecord::Base
  has_many :home_games, :class_name => "Event", :foreign_key => "home_team_id"
  has_many :away_games, :class_name => "Event", :foreign_key => "away_team_id"
  has_many :home_tailgates, :through => "home_games", :source => "tailgates"
  has_many :away_tailgates, :through => "away_games", :source => "tailgates"

  validates_presence_of :name, :background_image, :color, :sport
  validates :sport,
            inclusion: { in: ["College Football", "College Baseball", "NFL"] }

  def games
    self.home_games + self.away_games
  end

  def tailgates
    self.home_tailgates + self.away_tailgates
  end

  # TODO: This looks fragile to me, are you trying to get the team based on
  # the title of the tailgate? If that's the case I think I would go with a
  # regular association instead and if there is situations where the user
  # could create tailgates not associated with a team you could just have
  # a select in the html with the option to leave it blank.

  def total_tailgates
    events = Event.where("name LIKE '%#{self.name}%'")
    tailgates = 0
    events.each do |event|
      tailgates += event.tailgates.count
    end
    tailgates
  end

end
