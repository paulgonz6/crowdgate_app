class Booking < ActiveRecord::Base
  belongs_to :tailgate
  belongs_to :user
end
