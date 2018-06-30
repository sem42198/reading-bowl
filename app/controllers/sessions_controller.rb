class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by("LOWER(username) = ?", account_params[:username].downcase)

    if @user.present? && @user.authenticate(account_params[:password])
      session[:user_id] = @user.id
      redirect_to '/user_home'
    else
      render :new
    end
  end

  def destroy
    reset_session
    redirect_to '/'
  end

  def account_params
    params.require(:account).permit(:username, :password)
  end
end
