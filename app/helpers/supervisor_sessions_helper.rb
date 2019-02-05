module SupervisorSessionsHelper
  def current_supervisor
    @current_supervisor ||= Supervisor.find_by(id: session[:supervisor_id])
  end

  def supervisor_logged_in?
    !!current_supervisor
  end
    
end
