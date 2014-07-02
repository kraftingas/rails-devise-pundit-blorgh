require 'delegate'

class TextPostExhibit < Exhibit
  
  def self.applicable_to?(object)
    object.is_a?(Post) && (!object.picture?)
  end
  
  def render_body(template)
    #@context.render(partial: "/posts/text_body", locals: {post: self})
    template.render(partial: "/posts/text_body", locals: {post: self})
  end
  
end