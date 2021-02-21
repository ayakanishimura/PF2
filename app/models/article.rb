class Article < ApplicationRecord
  # アソシエーション
  belongs_to :user
  attachment :image
  has_many:article_comments, dependent: :destroy
  has_many:favorites, dependent: :destroy
  belongs_to :genre, optional: true

  # 公開・非公開設定
  enum status: { 公開: 0, 非公開: 1 }

  # バリデーション
  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200 }

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  #いいねランキング
  def self.favorite_ranking
    today = Time.zone.today
    articles = Article.where(start_time: today.beginning_of_month..today.end_of_month)
    article_ids = Favorite.
      where(article_id: articles.pluck(:id)).
      group(:article_id).
      order('count(article_id) desc').limit(5).pluck(:article_id)
    Article.find(article_ids)
  end

  def self.fevorite_ranking_onemonths
    one_months_ago = 1.months.ago
    one_months_ago_articles = Article.where(start_time: one_months_ago.beginning_of_month..one_months_ago.end_of_month)
    one_months_ago_article_ids = Favorite.
      where(article_id: one_months_ago_articles.pluck(:id)).
      group(:article_id).
      order('count(article_id) desc').limit(5).pluck(:article_id)
    Article.find(one_months_ago_article_ids)  
  end


end
