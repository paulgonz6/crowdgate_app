class Event < ActiveRecord::Base
  has_many  :tailgates, dependent: :destroy
  validates :name, presence: true, :uniqueness => true
  validates :date, presence: true
  validates :time, presence: true
  validates :venue, presence: true
  validates :city, presence: true
  validates :state, presence: true
end
