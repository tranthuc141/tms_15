class Supervisor::UsersController < ApplicationController
  before_action :supervisor
  
  def index
    @users = User.paginate page: params[:page]
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find params[:id]
  end

  def create
    @user = User.new user_params
    if @user.save
      redirect_to @user
    else
      render "new"
    end
  end

  def edit
    @user = User.find params[:id]
  end

  def update
    @user = User.find params[:id]
    if @user.update_attributes user_params
      flash[:success] = "Information changed"
      redirect_to supervisor_user_path @user
    else
      render "edit"
    end
  end

  def destroy
    @user = User.find params[:id]
    @user.destroy
    flash[:success] = "User has been deleted"
    redirect_to supervisor_users_url
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password,
     :password_confirmation, :address, :is_supervisor
  end

  def supervisor
    if logged_in?
      unless current_user.is_supervisor?
        flash[:danger] = "You must be supervisor"
        redirect_to root_url
      end
    else
      store_location
      flash[:danger] = "Please log in"
      redirect_to login_url
    end    
  end
end