module SessionsHelper
  # Checks if a user is logged in
  def logged_in?
    !session[:user_id].nil?
  end
end