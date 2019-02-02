class StoragesController < ApplicationController
  def new
    storage
    redirect_back(fallback_location: root_path)
  end
  
#全レシピの食材を登録する
  def storage
    
  recipes = Recipe.all
  recipes.each do |recipe|
    #テストとしてrecipe=Recipe.firstとする
    #recipe = Recipe.first
    unless Storage.find_by(recipe_id: recipe.id)
      recipe.materials.each_with_index do |material,i|
        material = material.delete("★,☆,◇,？,＞,>,＜,<,□,◆") #記号は削除する
        if Food.find_by(name: material)
          food = Storage.new(recipe_id: recipe.id, food_id: Food.find_by(name: material).id, material_no: i )
          food.save
        else
          if Food.find_by(hiragana: material)
            food = Storage.new(recipe_id: recipe.id, food_id: Food.find_by(hiragana: material).id, material_no: i )
            food.save
          else
            if Food.find_by(katakana: material)
              food = Storage.new(recipe_id: recipe.id, food_id: Food.find_by(katakana: material).id, material_no: i )
              food.save
            else
              if Food.find_by(kanzi: material)
                food = Storage.new(recipe_id: recipe.id, food_id: Food.find_by(kanzi: material).id, material_no: i )
                food.save
              else
                if Food.find_by(other1: material) 
                  food = Storage.new(recipe_id: recipe.id, food_id: Food.find_by(other1: material).id, material_no: i )
                  food.save
                else
                  if Food.find_by(other2: material)
                    food = Storage.new(recipe_id: recipe.id, food_id: Food.find_by(other2: material).id, material_no: i )
                    food.save
                  else
                    if Food.find_by(other3: material)
                      food = Storage.new(recipe_id: recipe.id, food_id: Food.find_by(other3: material).id, material_no: i )
                      food.save
                    else
                      #データベースに追加する処理を追加
                      f = Food.new(name: material)
                      f.save
                      food = Storage.new(recipe_id: recipe.id, food_id: Food.find_by(name: material).id, material_no: i )
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
  end
end
