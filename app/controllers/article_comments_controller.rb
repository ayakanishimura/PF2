class ArticleCommentsController < ApplicationController

  def create
    article = Article.find(params[:article_id])
    comment = ArticleComment.new(article_comment_params)
    comment.user_id = current_user.id
    comment.article_id = article.id
    comment.save
    # redirect_to article_path(article)
  end

  def destroy
    ArticleComment.find_by(id: params[:id], article_id: params[:article_id]).destroy
    # redirect_to article_path(params[:article_id])
  end

  private

  def article_comment_params
    params.require(:article_comment).permit(:comment)
  end

end
