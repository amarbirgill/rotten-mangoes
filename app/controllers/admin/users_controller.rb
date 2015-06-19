class Admin::UsersController < ApplicationController
  
  before_filter :restrict_admin_access

  def index
    @users = User.all.page(params[:page]).per(1)
  end

  def new 
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to movies_path, notice: "Welcome aboard Admin #{@user.firstname}!"
    else
      render :new
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to admin_users_path
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    # UserMailer.bye_email(@user).deliver_later 
    @user.destroy
    redirect_to admin_users_path, alert: "#{@user.firstname} deleted successfully"
  end

  protected

  def user_params
    params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation, :admin)
  end

end
