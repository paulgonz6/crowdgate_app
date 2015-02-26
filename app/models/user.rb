class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many  :tailgates, dependent: :destroy
  has_many  :tickets_purchased, :class_name => "Booking", :foreign_key => "user_id"

  def star_rating
    # TODO: Once again, consistency, or use arrows or use :
    values = Review.where(tailgate_id: self.tailgates.ids).pluck(:rating)

    if values.present?
      (values.sum / values.size.to_f).round(1)
    end
  end

  def hosting_experience
    tailgates.count
  end

  # TODO: I would use a association here instead, for example....
  # user has many reviews through tailgate. Then you could just do:
  # self.reviews
  def reviews_about_host
    Review.where({ :tailgate_id => (Tailgate.where({ :host => self }).pluck(:id)) })
  end

  # TODO: If you know a little bit of regex you could write this method in one line
  # def short_name
  #   name.gsub(/\s(\S){1}(.)+\z/, " \\1.")
  # end
  def short_name
    name_split = self.name.split
    first_name = name_split[0]
    last_initial = name_split[1][0]
    short_name = "#{first_name} #{last_initial}."
    return short_name
  end

  # TODO: Same idea of the reviews_about_host.
  # User has many bookings (or sales) through tailgate.
  # Then you could just say:
  # bookings.sum(:amount)
  def ticket_sales
    Booking.where({ :tailgate_id => (Tailgate.where({ :host => self }).pluck(:id)) }).sum(:amount)
  end


end
