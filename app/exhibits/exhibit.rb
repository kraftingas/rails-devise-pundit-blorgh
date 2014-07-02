require 'delegate'

class Exhibit < SimpleDelegator

  def initialize(model, context)
    @context = context
    super(model)
  end
  
  def to_model
    __getobj__
  end
  
  def class
    __getobj__.class
  end
    
  def self.exhibit(object, context)
    exhibits.inject(object) do |object, exhibit|
      exhibit.exhibit_if_applicable(object, context)
    end
  end
    
  def self.exhibit_if_applicable(object, context)
    if applicable_to?(object)
      new(object, context)
    else
      object
    end
  end
    
  def self.applicable_to?(object)
    false
  end
    
  def self.exhibit_query(*method_names)
    method_names.each do |name|
      define_method(name) do |*args, &block|
        exhibit(super(*args, &block))
      end
    end
  end
  private_class_method :exhibit_query
    
  def self.object_is_any_of?(object, *classes)
    # What with Rails development mode reloading making class matching
    # unreliable, plus wanting to avoid adding dependencies to
    # external class definitions if we can avoid it, we just match
    # against class/module name strings rather than the actual class
    # objects.
    # Note that '&' is the set intersection operator for Arrays. 
    (classes.map(&:to_s) & object.class.ancestors.map(&:name)).any?
  end
  private_class_method :object_is_any_of?
    
  def to_partial_path
    if __getobj__.respond_to?(:to_partial_path)
      __getobj__.to_partial_path
    else
      partialize_name(__getobj__.class.name)
    end
  end
    
  def render(template)
    template.render(:partial => to_partial_path, :object => self)
  end
    
  def self.exhibits
    [
      TextPostExhibit,
      PicturePostExhibit,
      LinkExhibit
    ]
  end
  
  private
  
  def partialize_name(name)
    "/#{name.underscore.pluralize}/#{name.demodulize.underscore}"
  end  
  
end