class Blog #< ActiveRecord::Base
  #attr_reader :entries
  # nezinau, ar reikia uzkomentuot
  include Taggable
  attr_writer :post_source
  
  #def initialize
    #@entries = []
  #end
  
  def initialize(entry_fetcher=Post.public_method(:most_recent)) #:most_recent :all
    @entry_fetcher = entry_fetcher
  end
  
  def title
    I18n.t 'blog_title'
  end
  
  def subtitle
    I18n.t 'blog_subtitle'
  end
  
  def new_post(*args)
    post_source.call(*args) do |p|
      p.blog = self
    end
  end
  
  def entries
    #@entries.sort_by{|e| e.pubdate}.reverse.take(10)
    #fetch_entries.sort_by{|e| e.pubdate}.reverse.take(10)
    fetch_entries
  end
  
  def add_entry(entry)
    #@entries << entry
    entry.save
    #spam_social_networks(entry)
  end
  
  def self.model_name
    ActiveModel::Name.new(self)
  end
  
  def post(id)
    i = id.to_i
    if i.is_a?(Integer) && i != 0
      entries.find_by_id(i)
    else
      entries.find_by_slug(id)
    end
  end
  
  def tags
    #Post.tags
    #TaggedBlog.new(self)
    #ItemTag.includes(:tag).map(&:name)
    #Taggable.all_tags_alphabetical
  end
  
  def filter_by_tag(tag)
    FilteredBlog.new(self, tag)
  end
  
  class FilteredBlog < DelegateClass(Blog)
    #include ::Conversions
    include Taggable
    
    def initialize(blog, tag)
      super(blog)
      @tag = tag
    end
   
    def entries
      #super.tagged(@tag)
      Taggable(super).tagged(@tag)
    end
  
  end
  
  #def to_s
    #title
  #end
  
  private
  
  def fetch_entries
    @entry_fetcher.()
  end
  
  def post_source
    @post_source ||= Post.public_method(:new)
  end
  
end