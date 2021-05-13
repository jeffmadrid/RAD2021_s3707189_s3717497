# no "Sessions controller", it's logic is placed here
class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update subscription] 
  before_action :redirect_to_correct_user, only: %i[show edit]



  def signup
    @user = User.new
  end
  
  def signed
    @user = User.new(signup_params)
    
    if @user.save
      log_in @user
      redirect_to back_path
    else
      # render since we want to retain the user.errors
      render 'signup'
    end
  end
  
  
  
  
  
  
  
  
  def login
    @user = User.new
  end
  
  def logged
    name = params[:user][:name]
    password = params[:user][:password]
    user = User.find_by(name: name)
    
    if user && user.authenticate(password)
      # user helper method (accessible since included module in ApplicationController)
      log_in user
      redirect_to back_path
    else
      @user = User.new(name: name, password: password)
      @user.login_errors
      render 'login'
    end
  end
  
  def logout
    log_out current_user
    redirect_to root_path
  end
  
  # editing user login details 
  
  def edit
  end
  
  def update
    if @user.update(login_params)
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  
  
  
  
  
  
  
  
  
  def show
    unless @user and logged_in? @user
      set_back_path user_path(@user)
      redirect_to current_user || prompt_path
    end
  end
  
  
  
  
  
  
  
  
  
  
  def subscription
    
    if @user.visitor
      @user.visitor.destroy
      render js: "alert('Your subscription has been revoked.')"
    else
      new_visitor = Visitor.new(email: @user.email)
      new_visitor.save
      render js: "alert('You are subscribed to R&J newsletter!')"
    end
  end
  
  
  
  
  
  
  
  
  
  
  def forgot_password
    @user = User.new
  end
  
  def forgot_password_create
    email = params[:user][:email]
    @user = User.find_by(email: email)
    if @user
      # pass as params[:user] so UserMailer can send an email
      @user.reset_password_mail
      redirect_to login_path, notice: "A link was sent to #{email} to reset your password"
    else 
      @user = User.new(email: email)
      @user.forgot_password_errors
      render 'forgot_password'
    end
  end
  
  
  
  def reset_password
    @user = User.find_by_signed_id(params[:token])
    redirect_to login_path, notice: "Your token expired, login again" unless @user
    
  end
  
  def reset_password_create
    @user = User.find_by_signed_id(params[:token])
    if @user.update(reset_password_params)
      redirect_to login_path, notice: "Your password is updated! Complete login to continue"
    else
      render 'reset_password'
    end
  end
  
  
  
  
  
  
  
  
  
  
  
  
  private
 
  def set_user
    @user = User.find_by(id: params[:id])
  end
 
  def signup_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
  def login_params
    params.require(:user).permit(:name, :password)
  end
  
  def reset_password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
  
  def redirect_to_correct_user
    unless @user and logged_in? @user
      redirect_to current_user || prompt_path
    end
  end
  
end
