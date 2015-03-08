class CourseSubjectRelationshipsController < ApplicationController
  before_action :supervisor

  def show
    @course = Course.find params[:course_id]
    @subjects = Subject.all
  end

  def update
    @course = Course.find params[:course_id]
    @training_progresses = @course.training_progresses
    @course.update_attributes course_subject_relationship_params
    current_user.update_progress_info @training_progresses
    flash[:success] = "Added subjects to course."
    redirect_to supervisor_course_path @course
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
