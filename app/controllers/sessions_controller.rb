class SessionsController < ApplicationController
  skip_before_action :validate_user

  def new; end

  def create
    @user = User.find_by('LOWER(username) = ?', account_params[:username].downcase)

    if @user.present? && @user.authenticate(account_params[:password])
      session[:user_id] = @user.id
      redirect_to '/user_home'
    else
      flash[:danger] = 'Incorrect username or password.'
      render :new
    end
  end

  def destroy
    user.clear_question_queue
    reset_session
    redirect_to '/'
  end

  def account_params
    params.require(:account).permit(:username, :password)
  end
end
