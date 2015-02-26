class Tailgate < ActiveRecord::Base
  belongs_to  :event
  belongs_to  :host, :class_name => "User", :foreign_key => "user_id"
  has_many    :guests, :through => "tickets_sold", :source => "user"
  has_many    :reviews
  has_many    :tickets_sold,
                :class_name => "Booking",
                :foreign_key => "tailgate_id",
                :dependent => :destroy

  validates_presence_of :event, :user, :name

  scope :free_tailgates,      -> { where(:type => 'FreeTailgate') }
  scope :paid_tailgates,      -> { where(:type => 'PaidTailgate') }
  scope :packaged_tailgates,  -> { where(:type => 'PackagedTailgate') }

  # TODO: I think I would store values like this in a constant instead of a method
  # http://rubylearning.com/satishtalim/ruby_constants.html
  def self.types
    %w(FreeTailgate PaidTailgate PackagedTailgate)
  end

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
