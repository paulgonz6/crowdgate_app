class Team < ActiveRecord::Base

  def total_tailgates
    events = Event.where("name LIKE '%#{self.name}%'")
    tailgates = 0
    events.each do |event|
      tailgates += event.tailgates.count
    end
    return tailgates
  end

end
