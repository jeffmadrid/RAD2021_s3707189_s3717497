# no "Sessions controller", it's logic is placed here
class UsersController < ApplicationController




  def signup
    @user = User.new
  end
  
  def signed
    @user = User.new(user_params)
    
    if @user.save
      log_in @user
      redirect_to @user
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
      redirect_to user
    else
      @user = User.new
      @user.login_errors(name, password)
      render 'login'
    end
  end
  
  def logout
    logger.info "LOGED OUT"
    log_out current_user
    redirect_to root_path
  end
  
  
  
  
  def show
    @user = User.find(params[:id])
    unless logged_in? @user
      redirect_to current_user || prompt_path
    end
  end
  
  
  
  
  private
 
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end