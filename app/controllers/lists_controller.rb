class ListsController < ApplicationController


  def create
    @list = List.new(list_params)
    @list.user_id = current_user.id
    
    if @list.save
      #list_recipesに登録
      @user = User.find(current_user.id)
      recipes = @user.buy_storage_recipes
      recipes.each do |recipe|
        @list_recipe = ListRecipe.new
        @list_recipe.list_id = @list.id
        @list_recipe.recipe_id = recipe.id
        @list_recipe.save
      end
      #買い物レシピから登録を削除
      @user.buy_storage_recipes.destroy_all
      flash[:success] = "買い物リストを登録しました。リストはマイページで確認できます。"
      redirect_back(fallback_location: root_path) 
    else
      flash[:danger]="買い物リストの登録に失敗しました。"
      redirect_back(fallback_location: root_path)
    end
    
    
    
  end

  def destroy
    @list = List.find(params[:id])
    @list.destroy
    flash[:success] = '買い物リストは正常に削除されました'
    redirect_to user_path(current_user)
  end
  
  def show
    @list = List.find(params[:id])
    list_recipes = ListRecipe.where(list_id: @list.id)
    @recipes = []
    list_recipes.each do |list_recipe|
      @recipes << Recipe.find(list_recipe.recipe_id)
    end
    list =[]
    @recipes.each do|recipe|
      @storages = Storage.where(recipe_id: recipe.id)
      @storages.each do |s|
        list << s.food_id 
      end 
    end
    @uniqlist = list.uniq 
  end
  
  def list_params
    params.require(:list).permit(:user_id, :list_name)
  end
end
