class RecipesController < ApplicationController

  
  def category
    
    @category_recipes = Recipe.where(category_id: params[:category_id]) 
  end
  
  def random
    @random_recipes = Recipe.order("RAND()").limit(5)
  end
  
  
  #データベースからカテゴリ別レシピランキングを表示
  def new
    
    update = Update.last.update_date
    @recipes= Recipe.where(update_date: update)
  end

  

end