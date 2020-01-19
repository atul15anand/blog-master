class SessionsController < ApplicationController
  
  def new
    # render a login form
  end

  def create
    # create a session for user
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id]= user.id
      flash[:success]= "Welcome #{user.username}"
      redirect_to user_path(user)
    else
      flash.now[:danger] = "Your login credentials do not match."
      render 'new'
    end
  end

  def destroy
    debugger
    # destroy session
    session[:user_id]= nil
    flash[:success] = "Successfully logged out."
    redirect_to root_path
  end
end
