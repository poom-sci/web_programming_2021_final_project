class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :restaurant
  has_many :likes, dependent: :delete_all
  validates :msg,presence:true

  def get_total_likes
    @sum_likes=self.likes.pluck('like_type').inject(0){|sum,x| sum + (x ? 1 : -1) }
    if @sum_likes>0
      return @sum_likes
    else
      return 0
    end
     
  end
end
