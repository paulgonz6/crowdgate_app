class Review < ActiveRecord::Base
  belongs_to :tailgate
  belongs_to :user

  validates_presence_of  :rating, :tailgate, :user

end
