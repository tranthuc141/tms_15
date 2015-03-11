class SubjectProgressesController < ApplicationController
  def new
    @subject_progress = SubjectProgress.find params[:subject_progress_id]
    @subject = Subject.find params[:subject_id]
    @course = Course.find params[:course_id]
    current_user.trainee_start_subject @subject_progress
    redirect_to course_subject_path @course.id, @subject
  end

  def update
    @subject = Subject.find params[:subject_id]
    @course = Course.find params[:course_id]
    if current_user.is_supervisor?
      tr_pro = TrainingProgress.find_by course_id: @course.id
      @subject_progresses = SubjectProgress.where training_progress_id: tr_pro.id,
        subject_id: @subject.id
      current_user.supervisor_finish_subject @subject_progresses
      redirect_to supervisor_course_subject_path @course, @subject
    else
      @training_progress = TrainingProgress.find_by course_id: @course.id,
        user_id: current_user
      @subject_progress = SubjectProgress.find_by subject_id: @subject.id,
        training_progress_id: @training_progress.id
      current_user.trainee_finish_subject @subject_progress
      redirect_to course_subject_path @course, @subject
    end
  end

  private
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
