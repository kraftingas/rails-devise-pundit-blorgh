module Taggable
  private
  
  def Taggable(item, tag_storage=::TagStorage.new(item))
    return item if item.kind_of?(::Taggable)
    item.extend(::Taggable)
    
    case item
    when ::Class, ::ActiveRecord::Relation
      item.extend(::TaggableRelation)
    else 
      item.extend(::TaggableRecord)
      item._tag_storage = tag_storage
    end
    item
  end
  
  #def self.included(base)
  #  base.send :helper_method, ::Taggable if base.respond_to? :helper_method
  #end
  
end