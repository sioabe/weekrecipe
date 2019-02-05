class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:show, :like_recipes, :buy_storage_recipes]
  before_action :correct_user, only: [:show]
  
  def show
    @user = User.find(params[:id])
    @like_recipes = @user.like_recipes
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'ユーザーを登録しました'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザー登録に失敗しました'
      render :new
    end
  end
  
  def like_recipes
    @user = User.find(params[:id])
    @likes = @user.like_recipes
    @likes.each do |like|
      @like_recipe = User.find(like.recipe_id)
    end
  end  
  
  def buy_storage_recipes
    @user = User.find(params[:id])
    @buy_storage_recipes = @user.buy_storage_recipes
    #@buy_storage_recipes.each do |recipe|
      #@buy_storage_recipe = User.find(recipe.recipe_id)
  end

  def correct_user
    user = User.find(params[:id])
    unless user == current_user
      redirect_to root_url
      flash[:danger]="権限がありません"
    end
  end

  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
