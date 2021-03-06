class User < ActiveRecord::Base
  enum role: [:user, :vip, :admin]
  after_initialize :set_default_role, :if => :new_record?
  #after_database_authentication :set_welcome_back
  has_many :posts
  has_many :contacts
  #has_many :attachinary_files
  #has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  #validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  has_attachment  :avatar, accept: [:jpg, :png, :gif]
  #mount_uploader :avatar, AvatarUploader
  #has_attachments :photos, maximum: 10
   attr_accessor :country_code

  #validates :avatar, presence: true
  
  def to_param
    "#{id}-#{name.parameterize}"
  end
  
  def country_name
    country = ISO3166::Country[country_code]
    country.translations[I18n.locale.to_s] || country.name
  end

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
  
  def avatar_changed?
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
