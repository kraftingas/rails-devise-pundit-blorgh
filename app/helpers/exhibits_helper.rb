module ExhibitsHelper
  
  #def exhibit(model, context)
    # Doing a string comparison because Rails class-reloading weirdness
    #case model.class.name
      #when 'Post'
      #if model.picture?
        #PicturePostExhibit.new(model, context)
      #else
        #TextPostExhibit.new(model, context)
      #end
    #else
      #model
    #end
  #end

  def exhibit(model, context)
    Exhibit.exhibit(model, context)
  end
  
end