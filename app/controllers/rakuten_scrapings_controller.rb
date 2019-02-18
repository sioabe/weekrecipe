class RakutenScrapingsController < ApplicationController
  def new
    scraping
    redirect_back(fallback_location: root_path)
  end
  
  def scraping
    require 'nokogiri'

    # URLに簡単にアクセスできるようにするためのライブラリ
    require 'open-uri'
    # CSV出力をできるようにするためのライブラリ
    require 'csv'


    #recipe.urlをループで回す。ただし、rakuten_scrapingテーブルにすでに登録されているレシピについては対象外。
    recipes = Recipe.all
    recipes.each do |recipe|
    
      unless RakutenScraping.find_by(recipe_id: recipe.id) 

        url = recipe.url
        charset = nil
        html = open(url) do |f|
          charset = f.charset
          f.read
        end

        

        doc = Nokogiri::HTML.parse(html, nil, charset)
        #取得した値をテーブルに保存する
        doc.xpath('//li[@itemprop="ingredients"]').each do |node|
          food = p node.css('.name').inner_text #food
          amount = p node.css('.amount').inner_text #amount
          food_edit = food.delete("★,☆,◇,？,＞,>,＜,<,□,◆,▼,・,〇,○,◎,＝,●,■") 
          i = RakutenScraping.new(recipe_id: recipe.id, rakuten_food_name: food, rakuten_food_amount: amount, edit_food_name: food_edit)
          i.save
        end
      end
    end
  end
  
  def edit
     @rakuten_scraping = RakutenScraping.find(params[:id])
  end
  
  def update
    @rakuten_scraping = RakutenScraping.find(params[:id])
    if @rakuten_scraping.update(rakuten_scraping_params)
      flash[:success] = 'food は正常に更新されました'
      redirect_back(fallback_location: root_path)
    else
      flash[:danger] = 'food は更新されませんでした'
      redirect_back(fallback_location: root_path)
    end
  end
  
  #rakuten_scrapingに情報を追加する
  def add_scraping
    @rakuten_scraping = RakutenScraping.new
  end
  
  def create
    @rakuten_scraping = RakutenScraping.new(create_rakuten_scraping_params)
    if @rakuten_scraping.save
      flash[:success] = '登録しました'
      redirect_back(fallback_location: root_path)
    else
      flash.now[:danger] = '登録に失敗しました'
      redirect_back(fallback_location: root_path)
    end
  end
  
  #rakuten_scrapingから削除する
  def destroy
    @rakuten_scraping = RakutenScraping.find(params[:id])
    @rakuten_scraping.destroy
    flash[:success] = '削除しました。'
    render 'supervisors/rakuten_scrapings', supervisors: @current_supervisor
  end
  
  private
  #Strong Parameter
  def rakuten_scraping_params
    params.require(:rakuten_scraping).permit(:rakuten_food_amount, :edit_food_name )
  end
  
  def create_rakuten_scraping_params
    params.require(:rakuten_scraping).permit(:recipe_id, :rakuten_food_name, :rakuten_food_amount, :edit_food_name )
  end
     
end
