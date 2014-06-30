class Comment < ActiveRecord::Base
  validates :text, presence: true
  
  def to_s
    text
  end
  
end
