class Review < ActiveRecord::Base
  belongs_to :tailgate
  belongs_to :user

  validates  :rating, presence: true

end
