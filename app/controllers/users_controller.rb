class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:show, :like_recipes]
  
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
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
