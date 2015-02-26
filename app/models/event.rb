class Event < ActiveRecord::Base
  has_many  :tailgates, dependent: :destroy
  validates :name, presence: true, :uniqueness => true
  validates :date, presence: true
  validates :time, presence: true
  validates :venue, presence: true
  validates :city, presence: true
  validates :state, presence: true

  def self.search(search)
    # TODO: search is not an optional attribute, I don't see the need for the if/else
    # the only possible unexpected thing would be nil, which would result on an empty
    # result which is fine.
    if search
      find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
    else
      find(:all)
    end
  end

end
