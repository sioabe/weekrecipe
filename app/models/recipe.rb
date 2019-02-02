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
  
  #食材登録
  has_many :storages
  has_many :recipe_materials, through: :storages, source: :food
  
  #買物リスト機能storage
  has_many :storage_lists
  has_many :buy_storage_users, through: :storage_lists, source: :user
  
  
end
