class StorageList < ApplicationRecord
  belongs_to :user
  belongs_to :recipe
  
   validate :check_number_of_recipes

 def check_number_of_recipes
  if user && user.buy_storage_recipes.count > 6
   errors.add(:user, "人数OVER")
  end
 end
end
