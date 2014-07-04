class User < ActiveRecord::Base
  enum role: [:user, :vip, :admin]
  after_initialize :set_default_role, :if => :new_record?
  #after_database_authentication :set_welcome_back
  has_many :posts
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  def set_default_role
    self.role ||= :vip
  end
  
  def set_welcome_back
    flash[:notice] = "Welcome Back"
  end
  
  def self.oldest
    order(:id)
  end
  
  def user_comments(id)
    Comment.where(commenter_id: id)
  end
  
  def to_s
    name
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
