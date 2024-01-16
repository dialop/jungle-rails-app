class SessionsController < ApplicationController
  # ...

  def new
    # Render the login form
  end

  def create
    user = User.authenticate_with_credentials(params[:session][:email], params[:session][:password])

    if user
      session[:user_id] = user.id
      # Check if the user is an admin and redirect accordingly
      if user.admin?
        redirect_to admin_dashboard_path, notice: 'Logged in as Admin!' # replace admin_dashboard_path with your actual path
      else
        redirect_to products_path, notice: 'Logged in!'
      end
    else
      Rails.logger.error("Login failed for email: #{params[:session][:email]}")
      redirect_to login_path, alert: 'Email or password is incorrect.'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: 'Logged out successfully'
  end
end
