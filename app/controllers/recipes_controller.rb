class RecipesController < ApplicationController
  def new
    @recipes = []
    @category_id = "30"
    results = RakutenWebService::Recipe.ranking(@category_id)
    results.each do|result|
      recipe = Recipe.new(read(result))
      @recipes << recipe
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
    category_id: category_id
    
  }
end
  