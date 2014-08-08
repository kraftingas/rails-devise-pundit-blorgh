class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include ExhibitsHelper
  include Taggable
  
  protect_from_forgery with: :exception
  
  before_filter :blog
  helper :exhibits
  
  #before_action :set_locale
 
  def set_locale
    #I18n.locale = params[:locale] || I18n.default_locale
    logger.debug "* Accept-Language: #{request.env['HTTP_ACCEPT_LANGUAGE']}"
    I18n.locale = extract_locale_from_accept_language_header || I18n.default_locale
    logger.debug "* Locale set to '#{I18n.locale}'"
  end
  
  def default_url_options(options={})
    logger.debug "default_url_options is passed options: #{options.inspect}\n"
    { locale: I18n.locale }
  end
  
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

  def extract_locale_from_accept_language_header
    request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
  end
end
