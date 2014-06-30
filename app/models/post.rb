class Post < ActiveRecord::Base
  LIMIT_DEFAULT = 20
  has_many :comments
  attr_accessor :author_name
  belongs_to :author, class_name: "Author"
  #Blorgh.author_class.to_s
    
  before_save :set_author
    
  def self.most_recent(limit=LIMIT_DEFAULT)
    order("created_at DESC").limit(limit)
  end
    
  private
    
  def set_author
    self.author = Author.find_or_create_by(name: author_name)
    #Blorgh.author_class.find_or_create_by(name: author_name)
  end
end
