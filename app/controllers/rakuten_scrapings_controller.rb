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
          i = RakutenScraping.new(recipe_id: recipe.id, rakuten_food_name: food, rakuten_food_amount: amount, edit_food_name: food)
          i.save
        end
        
      end
    end

  end
     
end
