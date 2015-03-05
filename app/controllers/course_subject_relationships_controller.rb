class CourseSubjectRelationshipsController < ApplicationController
  before_action :supervisor

  def show
    @course = Course.find params[:course_id]
    @subjects = Subject.all
  end

  def update
    @course = Course.find params[:course_id]
    if @course.update_attributes course_subject_relationship_params
      flash[:success] = "Added subjects to course."
      redirect_to course_path @course
    else
      flash[:error] = "Cannot add subjects to course."
      redirect_to course_course_subject_relationships_path @course
    end
  end

  private
  def course_subject_relationship_params
    params.require(:course).permit subject_ids: []
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
