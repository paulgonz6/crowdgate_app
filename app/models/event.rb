class Event < ActiveRecord::Base
  has_many  :tailgates, dependent: :destroy
  validates :name, presence: true, :uniqueness => true

  validates_presence_of :date, :time, :venue, :city, :state

end
