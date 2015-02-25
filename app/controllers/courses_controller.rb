class CoursesController < ApplicationController
  def show
    @course = Course.find params[:id]
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
  end

  private

  def course_params
    params.require(:course).permit :name, :description,
      course_subject_relationships_attributes: [:id, :subject_id, :_destroy]
  end
end
