class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many  :tailgates, dependent: :destroy
  has_many  :bookings

  def star_rating
    values = Review.where(tailgate_id: self.tailgates.ids).pluck(:rating)
    if values.present?
      (values.sum / values.size.to_f).round(1)
    end
  end

  def hosting_experience
    tailgates.count
  end

  def reviews_about_host
    Review.where({ :tailgate_id => (Tailgate.where({ :host => self }).pluck(:id)) })
  end

  def short_name
    name_split = self.name.split
    first_name = name_split[0]
    last_initial = name_split[1][0]
    short_name = "#{first_name} #{last_initial}."
    return short_name
  end

  def ticket_sales
    Booking.where({ :tailgate_id => (Tailgate.where({ :host => self }).pluck(:id)) }).sum(:amount)
  end


end
