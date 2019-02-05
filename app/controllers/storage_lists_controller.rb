class StorageListsController < ApplicationController
  
  def create
    recipe = Recipe.find(params[:recipe_id])
     #買物リストに登録できるレシピは５つのみ。
    #本当はmodelでvalidationしたいけどわからない・・・
    user = current_user
    if StorageList.where(user_id: user.id).count > 4
      flash[:danger] = '登録できるレシピは５つまでです'
      redirect_back(fallback_location: root_path)
    else
      current_user.record(recipe)
      flash[:success] = "買物リストに登録しました"
      redirect_back(fallback_location: root_path)
    end
  end
  
  def destroy
    recipe = Recipe.find(params[:recipe_id])
    current_user.unrecord(recipe)
    flash[:success]="買物リストから解除しました"
    redirect_back(fallback_location: root_path)
  end
end
