class UsersController < ApplicationController
  def show
    @user = User.find params[:id]
  end

  def index
    @users = User.paginate page: params[:page]
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:info] = "Created a trainee"
      redirect_to root_url
    else
      render 'new'
    end
  end

  def edit
    @user = User.find params[:id]
  end

  def show
  end

  def index
  end

  def destroy

  end

  def update

  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
     :password_confirmation)
  end
end
