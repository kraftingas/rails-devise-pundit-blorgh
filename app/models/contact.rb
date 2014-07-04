class Contact < ActiveRecord::Base
  belongs_to :user
  
  validates_presence_of :name
  validates_presence_of :email
  validates_presence_of :content
  validates_format_of :email, :with => /\A[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}\z/i
  validates_length_of :content, :maximum => 500
  
  def self.newest(id)
    where(user_id: id).order(id: :desc)
  end
  
  def self.counter(id)
    #Person.update(15, user_name: 'Samuel', group: 'expert')
    #select(:id, :shown_count).where(id: id).to_a
    update(id, shown_count: 1)
  end
  
end
