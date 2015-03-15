class SessionsController < ApplicationController
  def create
    email, password = params[:user][:email], params[:user][:password]
    user = User.find_by_credentials(email, password)

    if user.nil?
      flash.now[:errors] = ["Incorrect email and/or password"]
      render :new
    else
      login_user!(user)
      redirect_to user
    end
  end

  def new
    render :new
  end

  def destroy
    logout_user!
  end
end
