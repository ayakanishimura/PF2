class SearchController < ApplicationController
  before_action :authenticate_user!
  
  #キーワード検索
  def search
    @genres = Genre.all
    search_word = params[:search][:keyword]
    if search_word
      @articles = Article.where(['body LIKE ?', "%#{search_word}%"]).page(params[:page]).reverse_order
    else
      @articles = Article.all
    end
  end

  #ジャンル検索
  def genre_search
    genre_id = params[:search][:value]
    @articles = Article.where(genre_id: genre_id).page(params[:page]).reverse_order
    @genres = Genre.all
  end

end
