class Comment < ActiveRecord::Base
  belongs_to :post
  validates :text, presence: true
  before_validation :set_default_commenter
  
  #def initialize
    #self.order("created_at ASC")
  #end
  
  def to_s
    text
  end
  
  def self.oldest
    order("created_at")
  end
  
  private
  
  def set_default_commenter
    if commenter.blank?
      self.commenter = 'User000'
    end
  end
  
end
