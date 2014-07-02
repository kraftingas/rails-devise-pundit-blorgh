class CommentsController < ApplicationController
  
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
  
  def comment_params
    params.require(:comment).permit(:text, :commenter)
  end
  
end
