class PostsController < ApplicationController

  before_action :login_check, only: [:create,:update]
  before_action :find_user_post,   only: :destroy

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      options = {'user_email'=> @post.user.email,'user_name'=> @post.user.name}
      options.merge!(@post.as_json)
      # AddPostWorker.perform_async(options)
      AddPostWorker.perform_in(2.minutes,options)
      flash[:success] = "Post created successfully"
    else
      @feed_items = []
    end
    redirect_to root_url
  end

  def destroy
    @post.destroy
    flash[:success] = "Post Deleted"
    redirect_to request.referrer || root_url
  end

  def show
  	@post = Post.find(params[:id])
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end

  def find_user_post
    @post = current_user.posts.find_by(id: params[:id])
    redirect_to root_url if @post.nil?
  end

  def login_check
    unless user_signed_in?
      flash[:alert] = "User not logged in. Kindly log in."
      redirect_to root_url
    end
  end

end
