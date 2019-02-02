class UpdatesController < ApplicationController
  def new
    save_recipe
    save_category
    redirect_back(fallback_location: root_path)
  end
  
  #レシピ取得、データベースに保存する。
  def save_recipe
    save_category
    update = Update.new
    update.update_date = Date.today
    update.save
    @categories = Category.all
    @categories.each_with_index do |category,i|
      break if i==12  #全レシピ取得しようとすると５０４gatewaytimeout、なのでカテゴリは１２コまで。
      @results = RakutenWebService::Recipe.ranking(category.rakuten_category_id)
      @category_id = category.rakuten_category_id
      @results.each do|result|
        recipe = Recipe.new(read(result))
        if Recipe.find_by(rakuten_recipe_id: recipe.rakuten_recipe_id)
          r = Recipe.find_by(rakuten_recipe_id: recipe.rakuten_recipe_id)
          r.update_date = Date.today
          r.save
        else
          recipe.update_date = Date.today
          recipe.save
        end
      end
    end
  end
  
#カテゴリ取得、データベースに保存する。
  def save_category
    results = RakutenWebService::Recipe.large_categories
    results.each do|result|
      category = Category.new(category_read(result))
      #category.save
      if Category.find_by(rakuten_category_id: category.rakuten_category_id)
      else
        category.save
      end
    end
  end
  
private

#楽天APIレシピランキングの情報をread
def read(result)
  rakuten_recipe_id = result['recipeId']
  title = result['recipeTitle']
  url = result['recipeUrl']
  food_image_url =result['foodImageUrl']
  materials= result['recipeMaterial']
  category_id = @category_id
  {
    rakuten_recipe_id: rakuten_recipe_id,
    title: title,
    url: url,
    food_image_url: food_image_url,
    materials: materials,
    category_id: category_id,

  }
end

#楽天APIカテゴリーの情報をread
  def category_read(result)
    rakuten_category_id = result['categoryId']
    name = result['categoryName']
    url =result['categoryUrl']
    {
      rakuten_category_id: rakuten_category_id,
      name: name,
      url: url,
    }
  end


end
