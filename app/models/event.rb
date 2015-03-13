class Event < ActiveRecord::Base
  has_many  :tailgates, dependent: :destroy
  validates :name, presence: true, :uniqueness => true

  validates_presence_of :date, :time, :venue, :city, :state

  def live_tailgates
    self.tailgates.where("current_size > ?", 0)
  end
end
