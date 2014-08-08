require 'rails_helper'

RSpec.describe Post, :type => :model do
  
  before(:each) { @post = Post.new(title: 'Beautiful Title', text: 'Biiig body.') }

  subject { @post }

  it { should respond_to(:title) }

  it "#title returns a string" do
    expect(@post.title).to match 'Beautiful Title'
  end
  
  it "#text returns a string" do
    expect(@post.text).to match 'Biiig body.'
  end
  
#   it "#user_id" do
#   end
  
#   it "#image_url" do
#   end
  
#   it "#image" do
#   end
  
#   it "#tags" do
#   end
  
end
