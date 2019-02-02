class Food < ApplicationRecord
  
#食材登録
  has_many :storages
  has_many :material_recipes, through: :storages, source: :recipe
  
end
