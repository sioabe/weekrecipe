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
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_edit_params)
      flash[:success] = 'recipe は正常に更新されました'
      redirect_back(fallback_location: root_path)
    else
      flash[:danger] = 'recipe は更新されませんでした'
      redirect_back(fallback_location: root_path)
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
    make_list
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

  def make_list
    @list = []
    @user = User.find(params[:id])
    @user.buy_storage_recipes.each do|recipe|
      @storages = Storage.where(recipe_id: recipe.id)
      @storages.each do |s|
        @list << Food.find(s.food_id) 

      end 
    end
    @uniqlist = @list.uniq
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation,:picture)
  end
  
  def user_edit_params
    params.require(:user).permit(:picture)
  end
end
