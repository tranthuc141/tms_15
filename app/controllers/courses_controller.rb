class CoursesController < ApplicationController
  respond_to :html, :js

  def show
    @course = Course.find params[:id]
    @subjects = @course.subjects
    @users = @course.users
  end

  def index
    @courses = Course.paginate page: params[:page]
  end

  def new
    @course = Course.new
    @subjects = Subject.paginate page: params[:page]
  end

  def create
    @course = Course.new course_params
    if @course.save
      flash[:success] = "Create course successfully!"
      redirect_to courses_path
    else
      render 'new'
    end   
  end

  def edit
    @course = Course.find params[:id]
  end

  def update
    @course = Course.find params[:id]
    @course.update_attributes course_params
    redirect_to course_path @course
  end

  private

  def course_params
    params.require(:course).permit :name, :description,
      course_subject_relationships_attributes: [:id, :subject_id, :_destroy]
  end
end
