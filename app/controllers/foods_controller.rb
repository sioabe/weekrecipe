class FoodsController < ApplicationController
  before_action :require_supervisor_logged_in, only: [:edit, :update]
  
  def edit
     @food = Food.find(params[:id])
  end
  
  def update
    @food = Food.find(params[:id])
    if @food.update(food_params)
      flash[:success] = 'food は正常に更新されました'
      redirect_back(fallback_location: root_path)
    else
      flash[:danger] = 'food は更新されませんでした'
      redirect_back(fallback_location: root_path)
    end
  end
  
  private
  #Strong Parameter
  def food_params
    params.require(:food).permit(:name, :hiragana, :katakana, :kanzi, :other1, :other2, :other3 )
  end
  
end
