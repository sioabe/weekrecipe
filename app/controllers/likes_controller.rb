class LikesController < ApplicationController
  before_action :require_user_logged_in

  def create
    recipe = Recipe.find(params[:recipe_id])
    current_user.fav(recipe)
    flash[:success]='レシピをお気に入りに登録しました'
    redirect_back(fallback_location: root_path)
  end

  def destroy
    recipe = Recipe.find(params[:recipe_id])
    current_user.unfav(recipe)
    flash[:success] = 'レシピのお気に入りを解除しました'
    redirect_back(fallback_location: root_path)
  end
end
