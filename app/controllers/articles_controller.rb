class ArticlesController < ApplicationController

  def new
    @article = Article.new
    @genres = Genre.all
  end

  def create
    @article = Article.new(article_params)
    # binding.pry
    @article.user_id = current_user.id
    @article.save
    redirect_to articles_path
  end

  def index
    @articles = Article.page(params[:page]).reverse_order
    @genres = Genre.all
    #いいねランキング
    @all_ranks = Article.find(Favorite.group(:article_id).order('count(article_id) desc').limit(5).pluck(:article_id))
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
    params.require(:article).permit(:title, :body, :image, :genre_id)
  end

end
