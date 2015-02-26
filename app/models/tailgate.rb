class Tailgate < ActiveRecord::Base
  belongs_to    :event

  # TODO: Sometimes you use the => for hashes sometimes you use : .
  # Chose one and stick with that, conventions and consistency are
  # important things in your code

  belongs_to    :host, :class_name => "User", :foreign_key => "user_id"

  # TODO: I usually avoid lines that are longer than 70 or 80 columns of the editor
  # For example I would write something like that in this way:
  #
  # has_many  :tickets_sold,
  #   class_name: "Booking",
  #   foreign_key: "tailgate_id",
  #   dependent: :destroy
  #
  # The reason why I avoid long lines is because if you don't scroll there's a chance
  # you miss some important part of the code when maintaining it. I use this guideline
  # for everything (HTML, JS, CSS, Ruby)

  has_many      :tickets_sold, :class_name => "Booking", :foreign_key => "tailgate_id", dependent: :destroy
  has_many      :guests, :through => "tickets_sold", :source => "user"
  has_many      :reviews

  validates     :event_id, presence: true
  validates     :user_id, presence: true
  validates     :name, presence: true

  scope         :free_tailgates,      -> { where(type: 'FreeTailgate') }
  scope         :paid_tailgates,      -> { where(type: 'PaidTailgate') }
  scope         :packaged_tailgates,  -> { where(type: 'PackagedTailgate') }

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
