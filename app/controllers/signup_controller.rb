class SignupController < ApplicationController
  def new
  end

  def create
    @user = User.new(account_params)

    if @user.save
      cookies.signed[:user_id] = @user.id
      redirect_to '/user_home'
    else
      render :new
    end
  end

  def account_params
    account_params = params.require(:account)
    account_params[:user_type] = 'student'
    account_params[:hours_practiced] = 0.0
    account_params[:password] = nil unless account_params[:password] == account_params[:confirm_password]
    account_params.permit(:email, :username, :password, :first_name, :last_name,
                          :user_type, :hours_practiced)
  end
end
