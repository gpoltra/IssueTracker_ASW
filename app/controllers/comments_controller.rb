class CommentsController < ApplicationController
  
  def create
    @comment = Comment.new(comment_params)
    @micropost = Micropost.find(params[:micropost_id])
    @comment.issue_id = @micropost.id
    @comment.user_id = current_user.id
    @comment.save
    redirect_to show_microposts_path(@micropost)
  end

  def destroy
    @micropost = Micropost.find(params[:micropost_id])
    @comment = @micropost.comments.find(params[:id])
    @comment.destroy
    redirect_to show_microposts_path(@micropost)
  end
  
  private
    def comment_params
      params.require(:comment).permit(:body)
    end

    
end
