class SubjectProgressesController < ApplicationController
  def new
    @subject_progress = SubjectProgress.find params[:subject_progress_id]
    @course = Course.find params[:course_id]
    subject = Subject.find @subject_progress.subject_id
    current_user.trainee_start_subject @subject_progress
    redirect_to subject_path subject, course_id: @course.id
  end

  def destroy
    if current_user.is_supervisor?
      @subject = Subject.find params[:id]
      @course = Course.find params[:course_id]
      @subject_progresses = @subject.subject_progresses
      current_user.supervisor_finish_subject @subject_progresses
      redirect_to supervisor_subject_path @subject, course_id: @course.id
    else
      @subject_progress = SubjectProgress.find params[:id]
      @course = Course.find params[:course_id]
      subject = Subject.find @subject_progress.subject_id
      current_user.trainee_finish_subject @subject_progress
      redirect_to subject_path subject, course_id: @course.id
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
