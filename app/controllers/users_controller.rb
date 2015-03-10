class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]
  before_action :supervisor, only: :destroy

  def show
    @user = User.find params[:id]
    @course_list = @user.courses
  end

  def index
    @users = User.paginate page: params[:page]
  end

  def edit
    @user = User.find params[:id]
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to request.referrer
  end

  def update
    user = User.find params[:id]
    if user.update_attributes user_params
      if current_user? user
        flash[:success] = "Profile updated"
        redirect_to user
      else
        flash[:success] = "Information changed"
        redirect_to user
      end
    else
      render "edit"
    end
  end

private
  def user_params
    params.require(:user).permit :name, :email, :address, :password, :password_confirmation
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

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

  def correct_user
    @user = User.find params[:id]
    redirect_to root_url unless current_user.is_supervisor? || current_user?(@user)
  end
end