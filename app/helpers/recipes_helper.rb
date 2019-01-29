module RecipesHelper
  include CategoriesHelper
  
  #レシピ取得、データベースに保存する。
  def save_recipe
    @categories.each_with_index do |category,i|
      break if i==12  
    #categories = Category.all   #全レシピ部取得しようとすると５０４gatewaytimeout、なのでカテゴリは１２コまで。
    #categories.each do |category|
      results = RakutenWebService::Recipe.ranking(category.rakuten_category_id)
      @category_id = category.rakuten_category_id
      results.each do|result|
        recipe = Recipe.new(read(result))
        if Recipe.find_by(rakuten_recipe_id: recipe.rakuten_recipe_id)
        else
          recipe.save
        end
      end
    end
  end
  
  
  private

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

  
end

