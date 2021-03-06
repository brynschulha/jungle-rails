class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.authenticate_with_credentials(params[:email], params[:password])
    # If the user exists, and the password entered is correct
    if user # && user.authenticate(params[:password])
        # Save the user id inside the browser cookie
        # Logged in when they navigate around our website
        session[:user_id] = user.id
        redirect_to '/'
    else
      # If users login doesn't work, send them back to the login form.
      redirect_to '/login'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login'
  end
end