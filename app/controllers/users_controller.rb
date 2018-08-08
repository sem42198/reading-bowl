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
        flash[:danger] = 'Error creating account.'
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
    if params[:id]
      validate_admin
      @user = User.find(params[:id])
      skip_password = true
    else
      @user = user
    end
    data = update_params(skip_password)
    if data && @user.update_attributes(data)
      flash[:success] = 'Account updated.'
      redirect_to "/users/#{@user.id}"
    else
      flash[:danger] = 'Update failed.'
      if skip_password
        render "/users/#{@user.id}"
      else
        render :edit
      end
    end
  end

  def update_params(skip_password = false)
    update_params = params.require(:user)
    return nil unless @user.authenticate(update_params[:old_password]) || skip_password
    check_password_match(update_params) unless skip_password
    update_params.permit(:email, :first_name, :last_name, :password, :currently_reading)
  end

  def account_params
    account_params = params.require(:account)
    check_password_match(account_params)
    account_params.permit(:email, :username, :password, :first_name, :last_name,
                          :user_type)
  end

  def check_password_match(params)
    params[:password] = nil unless params[:password] == params[:confirm_password]
  end

  def home
    @user = user
    redirect_to '/' unless @user.present?
  end
end
