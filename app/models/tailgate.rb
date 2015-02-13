class Tailgate < ActiveRecord::Base
  belongs_to    :event
  belongs_to    :host, :class_name => "User", :foreign_key => "user_id"

  has_many      :bookings, dependent: :destroy
  has_many      :reviews
  has_many      :guests, :through => "bookings", :source => "user"

  validates     :event_id, presence: true
  validates     :user_id, presence: true
  validates     :name, presence: true
  validates     :price, presence: true
  validates     :size, presence: true

  def user_name
    user.name if user
  end

  def sold_out?
    size == 0
  end

  def host_experience
    user.hosting_experience
  end

end
