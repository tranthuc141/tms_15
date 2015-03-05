class Supervisor::CoursesController < ApplicationController
  before_action :supervisor

  def index
    @courses = Course.paginate page: params[:page]
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new course_params
    if @course.save
      flash[:success] = "Create course successfully!"
      redirect_to supervisor_courses_path
    else
      render 'new'
    end 
  end

  def show
    @course = Course.find params[:id]
    @subjects = @course.subjects
    @users = @course.users
  end

  def destroy
    @course = Course.find params[:id]
    @course.destroy
    redirect_to supervisor_courses_path
  end

  def edit
    @course = Course.find params[:id]
    @subject = Subject.new
  end

  def update
    @course = Course.find params[:id]
    @course.update_attributes course_params
    redirect_to supervisor_course_path @course
  end

  private

  def course_params
    params.require(:course).permit :name, :description,
      :subjects_attributes => [:id, :description, :name]
  end
  
  def supervisor
    if logged_in?
      unless current_user.is_supervisor?
        flash[:danger] = "You must be supervisor"
        redirect_to(root_url)
      end
    else
      store_location
      flash[:danger] = "Please log in"
      redirect_to login_url
    end    
  end
end
