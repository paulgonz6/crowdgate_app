class Team < ActiveRecord::Base

  # TODO: There's no reason to call return explicitly
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
    return tailgates
  end

end
