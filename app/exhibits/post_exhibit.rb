class PostExhibit < Exhibit
  
  def tags
    exhibit(Taggable(to_model).tags)
  end
  
end