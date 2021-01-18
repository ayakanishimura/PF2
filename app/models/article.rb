class Article < ApplicationRecord

#アソシエーション
  belongs_to :user
  attachment :image
  has_many:article_comments, dependent: :destroy
  has_many:favorites, dependent: :destroy
  belongs_to :genre

#公開・非公開設定
  enum status: { 公開: 0, 非公開: 1 }

#バリデーション
	validates :title, presence: true
	validates :body, presence: true, length: {maximum: 200}

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

end
