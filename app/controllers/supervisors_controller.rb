class SupervisorsController < ApplicationController
  before_action :require_supervisor_logged_in, only:[:show]
  before_action :correct_supervisor, only:[:show]
  
  def show
    @supervisor = Supervisor.find(params[:id])
  end

  def new
  end

  def create
  end
  
  def correct_supervisor
    supervisor = Supervisor.find(params[:id])
    unless supervisor.id == current_supervisor.id
      redirect_to root_url
      flash[:danger]="権限がありません"
    end
  end
  
  def foods
  end
  
  def recipes
  end
  
  def users
  end
  
end
