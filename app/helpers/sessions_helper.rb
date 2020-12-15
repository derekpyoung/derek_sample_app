module SessionsHelper

  #logs in the givin user.
  def log_in(user)
    session[:user_id] = user.id
  end
  #returns current logged in user.
  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end

  #returns true if the user is logged in, false otherwise.
  def logged_in?
    !current_user.nil?
  end

  #loggout helper
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
end
