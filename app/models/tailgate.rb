class Tailgate < ActiveRecord::Base
  belongs_to    :event
  belongs_to    :user
  has_many      :bookings, dependent: :destroy

  validates     :event_id, presence: true
  validates     :user_id, presence: true
  validates     :name, presence: true
  validates     :price, presence: true
  validates     :size, presence: true
end
