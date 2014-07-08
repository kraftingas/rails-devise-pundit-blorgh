class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  
  def edit
    Comment.change_comment(@comment)
  end
  
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params)
    if @comment.to_s == ''
      flash[:alert] = "Comment can't be blank!"
      #redirect_to post_path(@post)
    else
      flash[:notice] = "Comment has been created!"
      #redirect_to posts_path
    end
    redirect_to post_path(@post)
  end
 
  private
  
  attr_reader :comment
  helper_method :comment
  
  # Use callbacks to share common setup or constraints between actions.
  def set_comment
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
  end
  
  def comment_params
    params.require(:comment).permit(:text, :commenter, :commenter_ip, :commenter_id)
  end
  
end
