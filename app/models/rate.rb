class Rate < ApplicationRecord
  belongs_to :user
  belongs_to :restaurant
  validates :rate_score,presence:true

  enum rate_score: {
    '1':1,
    '2':2,
    '3':3,
    '4':4,
    '5':5
  }
end
