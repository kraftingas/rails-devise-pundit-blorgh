class Comment < ActiveRecord::Base
  belongs_to :post
  validates :text, presence: true
  
  def to_s
    text
  end
  
end
