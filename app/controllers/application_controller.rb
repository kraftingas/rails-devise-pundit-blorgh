class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include ExhibitsHelper
  include Taggable
  
  protect_from_forgery with: :exception
  
  before_filter :blog
  
  helper :exhibits
  
  def blog_url(*)
    root_url
  end
  
  private
  
  def blog
    @blog ||= exhibit(Blog.new, self)
    #turetu buti config/initializers/blog.rb su THE_BLOG = Blog.new ir tada cia
    #@blog = THE_BLOG
    #helper_method :blog
  end
  
  #def init_blog
  #  @blog = Blog.new
  #end
end
