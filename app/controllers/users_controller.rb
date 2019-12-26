class UsersController < ApplicationController

  before_action :authenticate_user!
  before_action :find_user, only: [:show,:edit,:update,:followers,:following]
  before_action :current_user_check, only: [:edit,:update]

  def index
    @users = User.paginate(page: params[:page], per_page: 10)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.paginate(page: params[:page], per_page: 10)
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile has been updated!"
      redirect_to (@user)
    else
      render 'edit'
    end
  end

  def following
  	@users = @user.following.paginate(page: params[:page])
  	render 'show_following'
  end

  def followers
  	@users = @user.followers.paginate(page: params[:page])
  	render 'show_followers'
  end

  private

  def user_params
    params.require(:user).permit(:name,:email,:password)
  end

  def find_user
    @user = User.find(params[:id])
  end

  def current_user_check
    if current_user != @user
      flash[:alert] = "You are not allowed to access that page!!"
      redirect_to root_url
    end
  end

end
