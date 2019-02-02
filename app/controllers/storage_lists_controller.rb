class StorageListsController < ApplicationController
  
 
  
  def create
    recipe = Recipe.find(params[:recipe_id])
    current_user.record(recipe)
    flash[:success] = "買物リストに登録しました"
    redirect_back(fallback_location: root_path)
  end
  
  def destroy
    recipe = Recipe.find(params[:recipe_id])
    current_user.unrecord(recipe)
    flash[:success]="買物リストから解除しました"
    redirect_back(fallback_location: root_path)
  end
end
