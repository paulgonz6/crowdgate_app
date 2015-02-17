class Tailgate < ActiveRecord::Base
  belongs_to    :event
  belongs_to    :host, :class_name => "User", :foreign_key => "user_id"

  has_many      :tickets_sold, :class_name => "Booking", :foreign_key => "tailgate_id", dependent: :destroy
  has_many      :guests, :through => "tickets_sold", :source => "user"
  has_many      :reviews

  validates     :event_id, presence: true
  validates     :user_id, presence: true
  validates     :name, presence: true
  validates     :price, presence: true
  validates     :original_size, presence: true

  def user_name
    user.name if user
  end

  def sold_out?
    current_size == 0
  end

  def host_experience
    user.hosting_experience
  end

end
