class MicropostsController < ApplicationController
  before_action :set_micropost, only: [:show, :edit, :update, :destroy]
  before_action :authenticate
  protect_from_forgery
  
  # GET /microposts
  # GET /microposts.json
  def index
    respond_to do |format|
      @microposts = Micropost.all
      
      if params.has_key?(:assignee)
          if User.exists?(id: params[:assignee])
            @microposts = @microposts.where(assignee_id: params[:assignee])
          else
            format.json {render json: {"error":"User with id="+params[:assignee]+" does not exist"}, status: :unprocessable_entity}
          end
      end
      
      if params.has_key?(:type_issue)
          @microposts = @microposts.where(type_issue: params[:type_issue])
      end
      
      if params.has_key?(:priority)
          @microposts = @microposts.where(priority: params[:priority])
      end
      
      if params.has_key?(:status)
          if params[:status] == "New&Open"
            @microposts = @microposts.where(status: ["Open","New"])
          else
            @microposts = @microposts.where(status: params[:status])
          end
      end
      
      if params.has_key?(:watcher)
          if User.exists?(id: params[:watcher])
            @microposts = Micropost.includes(:watchers).where(watchers:{user_id: params[:watcher]})
          else
            format.json {render json: {"error":"User with id="+params[:watcher]+" does not exist"}, status: :unprocessable_entity}
          end
      end
      
      format.html
      format.json {render json: @microposts}
    end
  end

  # GET /microposts/1
  # GET /microposts/1.json
  def show
    respond_to do |format|
      format.html
      format.json {render json: @micropost}
    end
  end

  # GET /microposts/new
  def new
    @micropost = Micropost.new
  end

  # GET /microposts/1/edit
  def edit
  end

  # POST /microposts
  # POST /microposts.json
  def create
    @micropost = Micropost.new(micropost_params)
    @micropost.user_id = current_user.id
    @micropost.assignee_id = current_user.id
    respond_to do |format|
      if @micropost.save
        @watcher = Watcher.new
        @watcher.user_id = current_user.id
        @watcher.micropost_id = @micropost.id
        @watcher.save
        @micropost.increment!("Watchers")
        format.html { redirect_to @micropost, notice: 'Micropost was successfully created.' }
        #format.json { render :show, status: :created, location: @micropost }
        format.json { render json: @micropost, status: :created}
      else
        format.html { render :new }
        format.json { render json: @micropost.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /microposts/1
  # PATCH/PUT /microposts/1.json
  def update
    respond_to do |format|
      if micropost_params.has_key?(:body)
        if (!micropost_params[:body].empty?)
          @comment = Comment.new
          @comment.body = micropost_params[:body]
          @comment.micropost_id = @micropost.id
          @comment.user_id = current_user.id
          @comment.save
        end
      end
      if @micropost.update(micropost_params.except(:body))
        format.html { redirect_to @micropost, notice: 'Micropost was successfully updated.' }
        format.json { render :show, status: :ok, location: @micropost }
      else
        format.html { render :edit }
        format.json { render json: @micropost.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def vote
    respond_to do |format|
      @issue_to_vote = Micropost.find(params[:id])
      if !Vote.exists?(:micropost_id => @issue_to_vote.id, :user_id => current_user.id)
        @vote = Vote.new
        @vote.user_id = current_user.id
        @vote.micropost_id = @issue_to_vote.id
        @vote.save
        @issue_to_vote.increment!(:Votes)
      else
        @vote = Vote.where(micropost_id: params[:id], user_id: current_user.id).take
        @vote.destroy
        @issue_to_vote.decrement!(:Votes)
      end
      format.html {redirect_to request.referrer}
      format.json { render json: @issue_to_vote, status: :ok }
    end
  end
  
  def watch
    respond_to do |format|
      @issue_to_watch = Micropost.find(params[:id])
      if !Watcher.exists?(:micropost_id => @issue_to_watch.id, :user_id => current_user.id)
        @watcher = Watcher.new
        @watcher.user_id = current_user.id
        @watcher.micropost_id = @issue_to_watch.id
        @watcher.save
        @issue_to_watch.increment!("Watchers")
      else
        @watcher = Watcher.where(micropost_id: params[:id], user_id: current_user.id).take
        @watcher.destroy
        @issue_to_watch.decrement!("Watchers")
      end
      format.html {redirect_to request.referrer}
      format.json { render json: @issue_to_watch, status: :ok }
    end
  end
  
  def update_status
    respond_to do |format|
      @issue_to_update = Micropost.find(params[:id])
      @issue_to_update.update_attribute("status", params[:status])
      
      format.html { redirect_to @issue_to_update }
      format.json { render json: @issue_to_update, status: :ok }
    end
  end
  
  def delete_attachment
    @attach_obj = ActiveStorage::Attachment.find(params[:micropost_id])
    @attach_obj.purge
    redirect_back(fallback_location: request.referer)
  end

  # DELETE /microposts/1
  # DELETE /microposts/1.json
  def destroy
    @issue = Micropost.find(params[:id])
    @issue.destroy
    respond_to do |format|
      format.html { redirect_to issues_url, notice: 'The issue was successfully destroyed.' }
      format.json { render json: {"message": "success"}, status: :ok }
    end
  end
  
  def authenticate
    if(!logged_in?)
      api_key = request.headers['X-Api-Key']
      @user = User.where(api_key: api_key).first if api_key
      unless @user
          head :unauthorized
        return false
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_micropost
      @micropost = Micropost.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def micropost_params
      params.require(:micropost).permit(:user_id, :title, :description, :type_issue, :priority, :assignee_id, :body, things: [])
    end
end
