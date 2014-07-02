class BlogExhibit < Exhibit
  
  def self.applicable_to?(object)
    object_is_any_of?(object, 'Blog', 'Blog::FilteredBlog')
  end
  
  def filter_by_tag(*)
    exhibit(super)
  end
  
  exhibit_query :filter_by_tag, :entries
  
end