class Post < ActiveRecord::Base
  LIMIT_DEFAULT = 3
  has_many :comments
  #attr_accessor :author
  belongs_to :user #, class_name: "User"
  #Blorgh.author_class.to_s
    
  #before_save :set_author
  
  def author
    User.find_by(id: user_id)
  end
    
  def self.most_recent(limit=LIMIT_DEFAULT)
    order("created_at DESC").limit(limit)
  end
    
  private
    
  def set_author
    #self.author = User.find_or_create_by(name: author_name)
    self.author = User.find_by(id: user_id)
    #Blorgh.author_class.find_or_create_by(name: author_name)
  end
end
