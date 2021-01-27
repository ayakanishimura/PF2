class SearchController < ApplicationController
  before_action :authenticate_user!
  def search
    @genres = Genre.all
    search_word = params[:search][:keyword]
    if search_word
      @articles = Article.where(['body LIKE ?', "%#{search_word}%"])
    else
      @articles = Article.all
    end
  end

  def genre_search
    genre_id = params[:search][:value]
    @articles = Article.where(genre_id: genre_id)
    @genres = Genre.all
  end



end
