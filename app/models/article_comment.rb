class ArticleComment < ApplicationRecord
  # アソシエーション
  belongs_to :user
  belongs_to :article

  # バリデーション
  validates :comment, presence: true
end
