class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many  :tailgates,
              :class_name => "Tailgate",
              :foreign_key => "host_id",
              :dependent => :destroy

  has_many  :sales,
              :through => 'tailgates',
              :source => 'tickets_sold'

  has_many  :written_reviews,
              :through => "tailgates",
              :source => "reviews"

  has_many  :reviews_as_host,
              :through => ''

  has_many  :tickets_purchased,
              :class_name => "Booking",
              :foreign_key => "user_id"

  def star_rating
    values = Review.where(:tailgate_id => self.tailgates.ids).pluck(:rating)
    if values.present?
      (values.sum / values.size.to_f).round(1)
    end
  end

  def hosting_experience
    tailgates.count
  end

  def short_name
    name.gsub(/\s(\S){1}(.)+\z/, " \\1.")
  end

end
