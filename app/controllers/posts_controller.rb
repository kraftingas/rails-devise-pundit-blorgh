class PostsController < ApplicationController
  respond_to :html, :json
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    #@posts = Post.all
    @posts = Post.most_recent
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    #@post = Post.find(params[:id])
    @post = exhibit(blog.post(params[:id]), self)
    respond_with(@post)
    #@previous = Post.where("id < ?", params[:id]).order(id: :desc).first
    #@next = Post.where("id > ?", params[:id]).order(:id).first
  end

  # GET /posts/new
  def new
    @post = blog.new_post
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    #@post = Post.new(post_params)
    #u = User.new
    #u.avatar = params[:file]
    #u.avatar = File.open('somewhere')
    #u.save!
    #u.avatar.url # => '/url/to/file.png'
    #u.avatar.current_path # => 'path/to/file.png'
    #u.avatar.identifier # => 'file.png'
    @post = Taggable(blog).new_post(post_params)
    #@post.image = params[:file]
    #Cloudinary::Uploader.upload(params[:image])
    
    #if params[:image_id].present?
      #preloaded = Cloudinary::PreloadedFile.new(params[:image_id])         
      #raise "Invalid upload signature" if !preloaded.valid?
      #@post.image_id = preloaded.identifier
    #end

    respond_to do |format|
      #if @post.save
      if @post.publish
        format.html { redirect_to @post , notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  
    attr_reader :post
    helper_method :post
  
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :text, :user_id, :image_url, :image, :tags)
    end
  
end
