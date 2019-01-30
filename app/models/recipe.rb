class Recipe < ApplicationRecord

  serialize :materials
  validates :rakuten_recipe_id, presence: true, length: { maximum: 255 }
  validates :title, presence: true, length: { maximum: 255 }
  validates :url, presence: true, length: { maximum: 255 }
  validates :food_image_url, presence: true, length: { maximum: 255 }
  validates :category_id, presence: true, length: { maximum: 255 }
  
  #お気に入り機能
  has_many :likes
  has_many :like_users, through: :likes, source: :user
  
  
  
end
