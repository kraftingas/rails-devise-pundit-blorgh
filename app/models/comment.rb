class Comment < ActiveRecord::Base
  belongs_to :post
  validates :text, presence: true
  before_validation :set_default_commenter #, :set_default_commenter_id
  
  #def initialize
    #self.order("created_at ASC")
  #end
  
  def to_s
    text
  end
  
  def self.oldest
    order("created_at")
  end
  
  def self.newest
    order("created_at DESC")
  end
  
  def hide_comment
    flash[:notice] = 'Comment was successfully destroyed.'
  end
  
  private
  
  def set_default_commenter
    if commenter.blank?
      self.commenter = 'User000'
    end
  end
  
  def set_default_commenter_id
    if commenter_id.nil?
      self.commenter_id = 0
    end
  end
  
end
