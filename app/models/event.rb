class Event < ActiveRecord::Base
  has_many  :tailgates, dependent: :destroy
  validates :name, presence: true, :uniqueness => true
  validates :date, presence: true
  validates :time, presence: true
  validates :venue, presence: true
  validates :city, presence: true
  validates :state, presence: true

  def self.search(search)
    if search
      find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
    else
      find(:all)
    end
  end

end
