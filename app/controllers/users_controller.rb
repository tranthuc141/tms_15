class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :show]
  before_action :correct_user,   only: [:edit, :update]
  
  def show
    @user = User.find params[:id]
  end

  def index
    @users = User.paginate page: params[:page]
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:info] = "Created a trainee"
      redirect_to root_url
    else
      render "new"
    end
  end

  def edit
    @user = User.find params[:id]
  end

  def update
    @user = User.find params[:id]
    @user.update_attributes user_params
    redirect_to user_url @user
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
     :password_confirmation, :address, :date_of_join,
     :avatar)
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

  def correct_user
    @user = User.find params[:id]
    redirect_to(root_url) unless current_user? @user
  end
end
