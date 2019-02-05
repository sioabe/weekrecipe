class RecipesController < ApplicationController
before_action :require_supervisor_logged_in, only: [:edit, :update]
  
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

  #レシピ編集用　
  def edit
    @recipe = Recipe.find(params[:id])
  end
  
  def update
    @recipe = Recipe.find(params[:id])
    if @recipe.update(recipe_params)
      flash[:success] = 'recipe は正常に更新されました'
      redirect_back(fallback_location: root_path)
    else
      flash[:danger] = 'recipe は更新されませんでした'
      redirect_back(fallback_location: root_path)
    end
  end
  
  private
  #Strong Parameter
  def recipe_params
    params.require(:recipe).permit(:title, :materials)
  end

end