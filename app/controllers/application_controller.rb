class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  include SessionsHelper
  include SupervisorSessionsHelper
  
private

  #ログイン済ユーザーのみ許可するためのメソッド
  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
    
  end
  
  #ログイン済管理者supervisorのみ許可するためのメソッド
  def require_supervisor_logged_in
    unless supervisor_logged_in?
      redirect_to root_path
    end
  end
  
  
  
end
