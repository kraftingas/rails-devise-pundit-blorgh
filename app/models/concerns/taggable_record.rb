module TaggableRecord
  attr_accessor :_tag_storage
  
  def tags
    _tag_list
  end
  
  def tags=(new_tags)
    @_tag_list = TagList.new(new_tags)
  end
  
  def save(*, &block)
    #self[:tags] = _tag_list.to_a
    #super
    super.tap do |successful|
      if successful
        _tag_storage.store(tags.to_a)
      end
    end
  end
  
  private
  
  def _tag_list
    #@_tag_list ||= TagList.new(self[:tags])
    @_tag_list ||= TagList.new(_tag_storage.load)
  end
  
end