class Post < ActiveRecord::Base
  LIMIT_DEFAULT = 10
  has_many :comments, dependent: :destroy 
  #attr_accessor :author_name
  belongs_to :user #, class_name: "User"
  validates :title, presence: true
  #Blorgh.author_class.to_s
    
  #before_save :set_author
  
  def author
    User.select(:name).find_by(id: user_id)
  end
    
  def self.most_recent(limit=LIMIT_DEFAULT)
    order("created_at DESC").limit(limit)
  end
    
  private
    
  def set_author
    #self.author = User.find_or_create_by(name: author_name)
    #self.author = User.author
    #Blorgh.author_class.find_or_create_by(name: author_name)
    #self.author = User.find_by(id: current_user.id)
    #self.author_name = 2
  end
end
