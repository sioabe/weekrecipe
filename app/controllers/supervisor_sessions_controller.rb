class SupervisorSessionsController < ApplicationController
  def new
  end

  def create
    email = params[:supervisor_session][:supervisor_email].downcase
    password = params[:supervisor_session][:supervisor_password]
    if supervisor_login(email,password)
      flash[:success] = "管理者さんお疲れ様。忘れずに更新してください。"
      redirect_to @supervisor
    else
      flash.now[:danger]='ログインに失敗しました'
      render 'new'
    end
  end
  
  def destroy
    session[:supervisor_id] = nil
    flash[:success] = "ログアウトしました"
    redirect_to root_path
  end
  
  private
  
  def supervisor_login(email,password)
    @supervisor = Supervisor.find_by(email: email)
    if @supervisor && @supervisor.authenticate(password)
      session[:supervisor_id] = @supervisor.id
      return true
    else
      return false
    end
  end
end
