class Event < ActiveRecord::Base
  default_scope { order('id DESC') }

  has_many  :tailgates, dependent: :destroy
  validates :name, presence: true, :uniqueness => true

  validates_presence_of :date, :venue, :city, :state

  def live_tailgates
    self.tailgates.where("current_size > ?", 0) && self.tailgates.where("live = ?", true)
  end
end
