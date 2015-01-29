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
    # Creates Average Rating for user- first find all tailgates for that user,
    # Find reviews associated with those tailgates, pluck out rating, compact removes nils, then take average
    users_tailgates = Tailgate.where({ :user_id => self.id })
    values = Review.where({:tailgate_id => users_tailgates.pluck(:id)}).pluck(:rating).compact
    @average = values.sum / values.size.to_f
    return @average
  end

end
