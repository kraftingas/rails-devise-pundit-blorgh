class Post < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged
  
  LIMIT_DEFAULT = 10
  has_many :comments, dependent: :destroy
  #has_many :attachinary_files
  #attr_accessor :author_name
  belongs_to :user #, class_name: "User"
  validates :title, presence: true
  #Blorgh.author_class.to_s
  attr_accessor :blog
  #has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  #validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  #has_attachment :image
  #mount_uploader :image, ImageUploader
    
  #before_save :set_author
#   def to_param
#     "#{id}-#{title.parameterize}"
#   end
  
  def author
    User.select(:name).find_by(id: user_id)
  end
    
  def publish
    #clock=DateTime.now
    return false unless valid?
    #self.pubdate = clock
    blog.add_entry(self)
  end
  
  def self.most_recent(limit=LIMIT_DEFAULT)
    order("id DESC") #.limit(limit)
  end
  
  def self.first_before(id)
    #where("created_at < ?", date).order("created_at DESC").first
    Post.where("id < ?", id).order(id: :desc).first
  end
  
  def self.first_after(id)
    #where("created_at < ?", date).order("created_at ASC").first
    Post.where("id > ?", id).order(:id).first
  end
  
  def picture?
    image_url.present?
  end
  
  def prev
    self.class.first_before(id)
  end
    
  def next
    self.class.first_after(id)
  end
      
  def up
    blog
  end
    
  def to_s
    title
  end
    
    def new_post?(date)
      if date > (Date.today - 6)
        return true
      end
      false
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
