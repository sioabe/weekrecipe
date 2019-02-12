class StoragesController < ApplicationController
  def new
    storage
    redirect_back(fallback_location: root_path)
  end
  
  #全レシピの食材を登録する。rakuten_scrapingsから食材は全て持ってくる
  def storage
    Storage.destroy_all
    rakuten_scrapings = RakutenScraping.all
    rakuten_scrapings.each do |scraping|
    
      if Food.find_by(name: scraping.edit_food_name)
        food = Storage.new(recipe_id: scraping.recipe_id, rakuten_scraping_id: scraping.id, food_id: Food.find_by(name: scraping.edit_food_name).id)    
        food.save
      else
        if Food.find_by(hiragana: scraping.edit_food_name)
          food = Storage.new(recipe_id: scraping.recipe_id, rakuten_scraping_id: scraping.id, food_id: Food.find_by(hiragana: scraping.edit_food_name).id)    
          food.save
        else
          if Food.find_by(katakana: scraping.edit_food_name)
            food = Storage.new(recipe_id: scraping.recipe_id, rakuten_scraping_id: scraping.id, food_id: Food.find_by(katakana: scraping.edit_food_name).id)    
            food.save
          else
            if Food.find_by(kanzi: scraping.edit_food_name)
              food = Storage.new(recipe_id: scraping.recipe_id, rakuten_scraping_id: scraping.id, food_id: Food.find_by(kanzi: scraping.edit_food_name).id)    
              food.save
            else
              if Food.find_by(other1: scraping.edit_food_name)
                food = Storage.new(recipe_id: scraping.recipe_id, rakuten_scraping_id: scraping.id, food_id: Food.find_by(other1: scraping.edit_food_name).id)    
                food.save
              else
                if Food.find_by(other2: scraping.edit_food_name)
                  food = Storage.new(recipe_id: scraping.recipe_id, rakuten_scraping_id: scraping.id, food_id: Food.find_by(other2: scraping.edit_food_name).id)    
                  food.save
                else
                  if Food.find_by(other3: scraping.edit_food_name)
                    food = Storage.new(recipe_id: scraping.recipe_id, rakuten_scraping_id: scraping.id, food_id: Food.find_by(other3: scraping.edit_food_name).id)    
                    food.save
                  else
                    #データベースに追加する処理を追加
                    f = Food.new(name: scraping.edit_food_name)
                    f.save
                    food = Storage.new(recipe_id: scraping.recipe_id, rakuten_scraping_id: scraping.id, food_id: Food.find_by(name: scraping.edit_food_name).id )
                    food.save
                  end
                end
              end
            end
          end
        end
      end
    end 
  end
end