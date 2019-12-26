class CommentsController < ApplicationController

  before_action :find_commentable, :only => [:create]
  # after_action :commented_user_name, :only => [:create]

  def new
    @comment = Comment.new
  end

  def create
    @comment = @commentable.comments.new(comment_params)
    @comment.commenter = current_user.id
    if @comment.save
      flash[:success] = "Comment posted"
      redirect_back(fallback_location: request.referrer)
    else
      flash[:alert] = "Error while posting comment #{@comment.errors[:body]}"
      redirect_back(fallback_location: request.referrer)
    end
  end

  def destroy
  	@comment = Comment.find_by_id(params[:id])
  	@comment.destroy
  	flash[:success] = "Comment Deleted"
    redirect_to request.referrer || root_url
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def find_commentable
    @commentable = Comment.find_by_id(params[:comment_id]) if params[:comment_id]
    @commentable = Post.find_by_id(params[:post_id]) if params[:post_id]
  end

end
