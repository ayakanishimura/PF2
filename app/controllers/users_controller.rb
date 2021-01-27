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

    #ランキング
    today = Time.zone.today
    articles = Article.where(start_time: today.beginning_of_month..today.end_of_month)
    article_ids = Favorite
      .where(article_id: articles.pluck(:id))
      .group(:article_id)
      .order('count(article_id) desc').limit(5).pluck(:article_id)
    @all_ranks = Article.find(article_ids)

    one_months_ago = 1.months.ago
    one_months_ago_articles = Article.where(start_time: one_months_ago.beginning_of_month..one_months_ago.end_of_month)
    one_months_ago_article_ids = Favorite
      .where(article_id: one_months_ago_articles.pluck(:id))
      .group(:article_id)
      .order('count(article_id) desc').limit(5).pluck(:article_id)
    @one_months_ago_ranks = Article.find(one_months_ago_article_ids)

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
