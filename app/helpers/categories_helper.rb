module CategoriesHelper
   #ランキング用。カテゴリ取得
  def category_new
    @categories = []
    results = RakutenWebService::Recipe.large_categories
    results.each do|result|
      category = Category.new(category_read(result))
      @categories << category
    end
  end


private

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