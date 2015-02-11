module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end

  def current_user?(user)
    user == current_user
  end

  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by id: user_id
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by id: user_id
    end
  end

  def supervisor?
    current_user.is_supervisor?
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out
    session.delete :user_id
    @current_user = nil
  end

  def redirect_back_or(default)
    redirect_to session[:forwarding_url] || default
    session.delete :forwarding_url
  end

  def store_location
    session[:forwarding_url] = request.url if request.get?
  end
end