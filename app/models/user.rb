class User < ActiveRecord::Base
  has_many :tailgates, dependent: :destroy
  has_many :reviews
end
