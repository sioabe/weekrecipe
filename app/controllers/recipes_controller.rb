class RecipesController < ApplicationController
  include RecipesHelper
  include CategoriesHelper
  
  before_action :category_new 
  def category
    @category_recipes = Recipe.where(category_id: params[:category_id]) 
  end
  
  def random
    @random_recipes = Recipe.order("RAND()").limit(5)
  end
  
  #最新のカテゴリ別レシピランキングを取得
  def new
    save_category
    save_recipe
    @recipes=[]
    @categories.each_with_index do |category,i|
      break if i==12  #全部表示させようとすると５０４gatewaytimeoutになる。
      results = RakutenWebService::Recipe.ranking(category.rakuten_category_id)
      @category_id = category.rakuten_category_id
      results.each do|result|
        recipe = Recipe.new(read(result))
        @recipes << recipe
      end
    end
  end


end