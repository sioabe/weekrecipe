class RecipesController < ApplicationController
before_action :require_supervisor_logged_in, only: [:edit, :update]
  
  def category
    if params[:category_id].present?
      @category_recipes = Recipe.where(category_id: params[:category_id]) 
    else
      # パラメーターを受け取れていないなら
      @category_recipes = Recipe.where(category_id: Category.first.rakuten_category_id)
    end
  end
  
  def random
    # ちょとコメントすると、Rails.env.development? の場合は↑を、そうでない場合は下を
    # みたいな分岐条件で対処する、とかですかね...by @mentor-uchiyama
    # 但しこのような環境依存な分岐条件は、多用すると見通しが悪くなりがち。
    # 極力利用を控えることを検討されてみてください！
    if Rails.env.development?
      @random_recipes = Recipe.order("RAND()").limit(5)  #MySQL用
    else
      @random_recipes = Recipe.order("RANDOM()").limit(5)
    end
  end
  
  def search
    keyword = params[:keyword]
    @storages = []
    unless keyword == nil
      if Food.find_by(name: keyword)
        food_id = Food.find_by(name: keyword).id
        @storages = Storage.where(food_id: food_id)
      elsif Food.find_by(hiragana: keyword)
        food_id = Food.find_by(hiragana: keyword).id
        @storages = Storage.where(food_id: food_id)
      elsif Food.find_by(katakana: keyword)
        food_id = Food.find_by(katakana: keyword).id
        @storages = Storage.where(food_id: food_id)
      elsif Food.find_by(kanzi: keyword)
        food_id = Food.find_by(kanzi: keyword).id
        @storages = Storage.where(food_id: food_id)
      elsif Food.find_by(other1: keyword)
        food_id = Food.find_by(other1: keyword).id
        @storages = Storage.where(food_id: food_id)
      elsif Food.find_by(other2: keyword)
        food_id = Food.find_by(other2: keyword).id
        @storages = Storage.where(food_id: food_id)
      elsif Food.find_by(other3: keyword)
        food_id = Food.find_by(other3: keyword).id
        @storages = Storage.where(food_id: food_id)
      else
        #対応するキーワードの食材が登録されていない場合
        @storages = []
      end

    end
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