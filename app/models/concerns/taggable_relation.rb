module TaggableRelation
  
  def new(attrs={}, &block)
    attrs = attrs.dup
    tags  = attrs.delete(:tags)
    Taggable(super(attrs, &block)).tap do |item|
      item.tags = tags
    end
  end
  
  def all_tags_alphabetical
    all_tags.alphabetical
    "all_tags tekstas"
  end
  
  def all_tags
    #except(:limit).map{|e| Taggable(e).tags}.reduce(TagList.new([]), &:+)
    #TagList(ItemTag.where(item_type: klass).includes(:tag).map(&:name))
    "tekstas is taggable_relation"
  end
  
  def tagged(tag)
    #select{|e| Taggable(e).tags.include?(tag)}
    joins("JOIN item_tags ON item_tags.item_id = #{table_name}.id /*AND item_tags.item_type = \"#{klass.name}\"*/").
    joins("JOIN tags ON item_tags.tag_id = tags.id").
    where("tags.name LIKE ?", "%#{tag}%")
  end
  
  #def self.included(base)
  #  base.send :helper_method, :all_tags_alphabetical if base.respond_to? :helper_method
  #end
  
end