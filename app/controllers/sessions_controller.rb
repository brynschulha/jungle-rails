class SessionsController < ApplicationController

  def new
    puts "*************"
    puts "is the new action working"
    puts "*************"
  end

  def create
    puts "*************"
    puts params
    puts "*************"
    user = User.find_by_email(params[:email])
    # If the user exists, and the password entered is correct
    if user && user.authenticate(params[:password])
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