class User < ActiveRecord::Base
  has_many  :tailgates, dependent: :destroy
  has_many  :reviews
  has_many  :bookings

  before_save { self.email = email.downcase }
  validates :name,      presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email,     presence: true, length: { maximum: 255 },
                        format: { with: VALID_EMAIL_REGEX },
                        uniqueness: { case_sensitive: false }

  has_secure_password

  def star_rating
    values = Review.where(tailgate_id: self.tailgates.ids).pluck(:rating)
    if values.present?
      (values.sum / values.size.to_f).round(1)
    end
  end

  def hosting_experience
    tailgates.count
  end

  def short_name
    name_split = self.name.split
    first_name = name_split[0]
    last_initial = name_split[1][0]
    short_name = "#{first_name} #{last_initial}."
    return short_name
  end


end
