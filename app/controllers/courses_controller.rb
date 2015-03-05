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

  private
  def course_params
    params.require(:course).permit :name, :description,
      course_subject_relationships_attributes: [:id, :subject_id, :_destroy]
  end
end
