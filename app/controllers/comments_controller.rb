class CommentsController < ApplicationController
  
  def index
    @micropost = Micropost.find(params[:micropost_id])
    comments = @micropost.comments
    respond_to do |format|
      format.json {render json: comments, status: :ok}
    end
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
    @micropost = Micropost.find(params[:micropost_id])
    @comment = @micropost.comments.find(params[:id])
    respond_to do |format|
      format.json {render json: @comment, status: :ok}
    end
  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
    @micropost = Micropost.find(params[:micropost_id])
    @comment = @micropost.comments.find(params[:id])
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new(comment_params)
    @micropost = Micropost.find(params[:micropost_id])
    @comment.micropost_id = @micropost.id
    @comment.user_id = current_user.id
    @comment.save
    respond_to do |format|
      format.json {render json: @comment, status: :created}
      format.html {redirect_to request.referrer}
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    @micropost = Micropost.find(params[:micropost_id])
    @comment = @micropost.comments.find(params[:id])
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @micropost, notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @micropost = Micropost.find(params[:micropost_id])
    @comment = @micropost.comments.find(params[:id])
    if (logged_in?)
      if @comment.user_id == current_user.id
        @comment.destroy
      end
      respond_to do |format|
        if @comment.user_id == current_user.id
          format.json {render json: {}, status: :ok}
          format.html {redirect_to request.referrer}
        else
          format.json {render json: {error: "Forbidden, you are not the creator of this comment"}, status: :forbidden}
        end
      end
    else
      if (comment_params.has_key?(:user_id))
        if (@comment.user_id == comment_params[:user_id])
          @comment.destroy
          respond_to do |format|
            format.json {render json: {"message": "Delete success"}, status: :ok}
            format.html {redirect_to request.referrer}
          end
        end
        respond_to do |format|
          format.json {render json: {}, status: :forbidden}
          format.html {redirect_to request.referrer}
        end
      end
      format.json {render json: {}, status: :unprocessable_entity}
      format.html {redirect_to request.referrer}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:body, :user_id)
    end
end
