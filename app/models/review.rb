class Review < ActiveRecord::Base
  belongs_to :tailgate

  validates  :rating, presence: true

end
