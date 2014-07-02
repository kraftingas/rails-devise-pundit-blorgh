class BlogController < ApplicationController
  
  def index
    #@blog = Blog.new
    #post1 = @blog.new_post
    #post1.title = "Paint just applied"
    #post1.body = "Paint just applied. It's a lovely orangey-purple!"
    #post1.publish
    #post2 = @blog.new_post(title: "Still wet")
    #post2.body = "Paint is still quite wet. No bubbling yet!"
    #post2.publish
    if params[:tag].present?
      @blog = blog.filter_by_tag(params[:tag])
    end
  end
  
  def blog
    if params[:tag].present?
      super.filter_by_tag(params[:tag])
      #apacioj uzkomentuotas niekam tikes kodas
      #exhibit(super.filter_by_tag(params[:tag]))
    else
      super
    end
  end
  
end
