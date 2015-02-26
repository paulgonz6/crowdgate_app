class Review < ActiveRecord::Base
  belongs_to :tailgate
  belongs_to :user

  # TODO: quick hinte, if you are just using presence validation you could use
  # validates_presence_of :rating, :tailgate_id, :user_id
  #
  # Another hint is that when you are validating foreign keys like tailgate_id and user_id
  # if better to just validate the object, that way the validation message will be more
  # user friendly. For example:
  # validates_presence_of :rating, :tailgate, :user
  # http://api.rubyonrails.org/classes/ActiveModel/Validations/HelperMethods.html

  validates  :rating, presence: true
  validates  :tailgate_id, presence: true
  validates  :user_id, presence: true

end
