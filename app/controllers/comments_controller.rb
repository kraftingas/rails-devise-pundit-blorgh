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
  
  def destroy
    #@comment.destroy
    @post = Post.find(params[:post_id])
    @comment.hide_comment
    respond_to do |format|
      #format.html { redirect_to posts_url, notice: 'Comment was successfully destroyed.' }
      format.html { redirect_to post_path(@post) }
      format.json { head :no_content }
    end
  end
 
  private
  
  def comment_params
    params.require(:comment).permit(:text, :commenter, :commenter_ip, :commenter_id)
  end
  
end
