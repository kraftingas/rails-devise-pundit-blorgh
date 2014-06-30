class User < ActiveRecord::Base
  enum role: [:user, :vip, :admin]
  after_initialize :set_default_role, :if => :new_record?
  #after_database_authentication :set_welcome_back
  has_many :posts

  def set_default_role
    self.role ||= :user
  end
  
  def set_welcome_back
    flash[:notice] = "Welcome Back"
  end
  
  def to_s
    name
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
