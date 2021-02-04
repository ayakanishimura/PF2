class ArticlesController < ApplicationController
  before_action :authenticate_user!

  def new
    @article = Article.new
    @genres = Genre.all
    @articles = Article.page(params[:page]).reverse_order
  end

  def create
    @genres = Genre.all
    @article = Article.new(article_params)
    @article.user_id = current_user.id
    @article.score = Language.get_data(article_params[:body])
    @article.save
    # start_timeはcreateされた日時を指すため、create後に確定される
    if @article.update(start_time: @article.created_at)
      flash[:notice] = "投稿が成功しました!!"
      redirect_to articles_path
    else
      @genres = Genre.all
      @articles = Article.page(params[:page]).reverse_order
      render :new
    end
  end

  def index
    @articles = Article.where(status: 0).page(params[:page]).reverse_order
    @genres = Genre.all

    # 当月いいねランキング
    today = Time.zone.today
    articles = Article.where(start_time: today.beginning_of_month..today.end_of_month)
    article_ids = Favorite.
      where(article_id: articles.pluck(:id)).
      group(:article_id).
      order('count(article_id) desc').limit(5).pluck(:article_id)
    @all_ranks = Article.find(article_ids)

    # 前月いいねランキング
    one_months_ago = 1.months.ago
    one_months_ago_articles = Article.where(start_time: one_months_ago.beginning_of_month..one_months_ago.end_of_month)
    one_months_ago_article_ids = Favorite.
      where(article_id: one_months_ago_articles.pluck(:id)).
      group(:article_id).
      order('count(article_id) desc').limit(5).pluck(:article_id)
    @one_months_ago_ranks = Article.find(one_months_ago_article_ids)
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
    @genres = Genre.all
  end

  def update
    @genres = Genre.all
    @article = Article.find(params[:id])
    if @article.update(article_params)
      flash[:notice] = "編集に成功しました"
      redirect_to article_path(@article.id)
    else
      render :edit
    end
  end

  def myindex
    @user = User.find(params[:id])
    @genres = Genre.all

    # 表示の条件（公開・非公開）
    if @user.id == current_user.id
      @articles = Article.where(user_id: @user.id).page(params[:page]).reverse_order
    else
      @articles = Article.where(status: 0, user_id: @user.id).page(params[:page]).reverse_order
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :body, :image, :genre_id, :start_time, :status)
  end
end
