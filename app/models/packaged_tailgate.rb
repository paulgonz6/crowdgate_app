class PackagedTailgate < Tailgate
  validates :price, presence: true
  validates :original_size, numericality: { equal_to: 1 }
end
