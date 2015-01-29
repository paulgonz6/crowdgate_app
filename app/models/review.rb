class Review < ActiveRecord::Base
  belongs_to :tailgate
  belongs_to :user

  validates  :rating, presence: true
  validates  :tailgate_id, presence: true
  validates  :user_id, presence: true

end
