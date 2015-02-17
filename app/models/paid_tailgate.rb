class PaidTailgate < Tailgate
  validates     :price, presence: true
  validates     :original_size, presence: true
end
