class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  
  has_secure_password
  
  mount_uploader :picture, PictureUploader
  
  #お気に入り機能
  has_many :likes
  has_many :like_recipes, through: :likes, source: :recipe
  
  def fav(recipe)
    self.likes.find_or_create_by(recipe_id: recipe.id)
  end
  
  def unfav(recipe)
    like = self.likes.find_by(recipe_id: recipe.id)
    like.destroy if like
  end

  def fav?(recipe)
    self.like_recipes.include?(recipe)
  end
  
  #買物リスト機能storage
  has_many :storage_lists
  has_many :buy_storage_recipes, through: :storage_lists, source: :recipe
  
  def record(recipe)
    self.storage_lists.find_or_create_by(recipe_id: recipe.id)
  end
  
  def unrecord(recipe)
    storage_list = self.storage_lists.find_by(recipe_id: recipe.id)
    storage_list.destroy if storage_list
  end
  
  def record?(recipe)
    self.buy_storage_recipes.include?(recipe)
  end
  
end
