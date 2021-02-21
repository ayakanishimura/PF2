class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @articles = @user.articles
    @article = Article.new
    @genres = Genre.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def index
    @users = User.all
    # 当月いいねランキング
    @all_ranks = Article.favorite_ranking
    # 先月いいねランキング
    @one_months_ago_ranks = Article.fevorite_ranking_onemonths
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user)
  end

  def follows
    user = User.find(params[:id])
    @users = user.followings
  end

  def followers
    user = User.find(params[:id])
    @users = user.followers
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction)
  end
end
