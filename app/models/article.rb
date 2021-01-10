class Article < ApplicationRecord

  belongs_to :user
  attachment :image
end
