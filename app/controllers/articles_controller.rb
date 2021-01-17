class ArticlesController < ApplicationController

  def new
    @article = Article.new
    @genres = Genre.all
    @articles = Article.page(params[:page]).reverse_order
  end

  def create
    article = Article.new(article_params)
    # binding.pry
    article.user_id = current_user.id
    article.save
    # start_timeはcreateされた日時を指すため、create後に確定される
    article.update(start_time:article.created_at)
    redirect_to articles_path
  end

  def index
    @articles = Article.page(params[:page]).reverse_order
    @genres = Genre.all
    #いいねランキング
    # @all_ranks = Article.find(Favorite.group(:article_id).order('count(article_id) desc').limit(5).pluck(:article_id))

    # today = Time.zone.today
    # articles = Article.where(start_time: today.beginning_of_month..today.end_of_month)
    # article_ids = Favorite
    #   .where(article_id: articles.pluck(:id))
    #   .group(:article_id)
    #   .order('count(article_id) desc').limit(5).pluck(:article_id)
    # @all_ranks = Article.where(id: article_ids)

    # one_months_ago = 1.months.ago
    # one_months_ago_articles = Article.where(start_time: one_months_ago.beginning_of_month..one_months_ago.end_of_month)
    # one_months_ago_article_ids = Favorite
    #   .where(article_id: one_months_ago_articles.pluck(:id))
    #   .group(:article_id)
    #   .order('count(article_id) desc').limit(5).pluck(:article_id)
    # @one_months_ago_ranks = Article.where(id: one_months_ago_article_ids)

  end

  def show
    @article = Article.find(params[:id])
    @article_comment = ArticleComment.new
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_path
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    @article.update(article_params)
    redirect_to article_path(@article.id)
  end


private

  def article_params
    params.require(:article).permit(:title, :body, :image, :genre_id, :start_time)
  end

end
