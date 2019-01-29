class RecipesController < ApplicationController
  include RecipesHelper
  include CategoriesHelper
  
  before_action :category_new 
  def category
    save_category
  end
  
  def random
    save_recipe
  end
  
  #最新のカテゴリ別レシピランキングを取得
  def new
    @recipes=[]
    @categories.each_with_index do |category,i|
      break if i==3  #全部表示させようとすると５０４gatewaytimeoutになる。
      results = RakutenWebService::Recipe.ranking(category.rakuten_category_id)
      @category_id = category.rakuten_category_id
      results.each do|result|
        recipe = Recipe.new(read(result))
        @recipes << recipe
      end
    end
  end


end