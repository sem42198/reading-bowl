class UsersController < ApplicationController

  skip_before_action :validate_user, :only => [:new, :create]
  before_action :validate_admin, :only => [:index]

  def new
    @create_admin = params[:admin]
    validate_admin if @create_admin
  end

  def create
    @user = User.new(account_params)

    if @user.student? || validate_admin

      if @user.save
        flash[:success] = 'Account created.'
        session[:user_id] ||= @user.id
        redirect_to '/user_home'
      else
        flash[:danger] = errors_for @user
        render :new
      end
    end
  end

  def index; end

  def show
    @user = User.find(params[:id])
    validate_admin unless @user == user
  end

  def edit
    @user = user
  end

  def update
    skip_password = false
    if params[:id] && validate_admin
      @user = User.find(params[:id])
      skip_password = true
    end
    @user ||= user

    if @user == user || validate_admin
      data = update_params(skip_password)

      unless data
        flash[:danger] = 'Incorrect current password'
        return render :edit
      end

      if @user.update_attributes(data)
        flash[:success] = 'Account updated.'
        redirect_to "/users/#{@user.id}"
      else
        flash[:danger] = errors_for(@user)
        if skip_password
          render "/users/#{@user.id}"
        else
          render :edit
        end
      end
    end
  end

  def update_params(skip_password = false)
    return nil unless @user.authenticate(params[:user][:old_password]) || skip_password

    params.require(:user).permit(:email, :first_name, :last_name, :password,
                                 :password_confirmation, :currently_reading)
  end

  def account_params
    params.require(:user).permit(:user_type, :email, :username, :password,
                                    :password_confirmation, :first_name,
                                    :last_name)
  end

  def home
    @user = user
    redirect_to '/' unless @user.present?
  end
end
