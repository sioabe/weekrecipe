module SessionsHelper
  def current_user
=begin
  if @current_user
    return @current_user
  else
    @current_user = User.find_by(id: session[:user_id])
    return @current_user
  end
=end
    @current_user ||= User.find_by(id: session[:user_id])
  end
  
  def logged_in?
=begin
    if current_user
      return true
    else
      return false
    end
=end
    !!current_user
  end
end
