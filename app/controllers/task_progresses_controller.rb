class TaskProgressesController < ApplicationController
  def update
    task = Task.find params[:id]
    @subject = task.subject
    @course = Course.find params[:course_id]
    task_progress = task.get_task_progress task, current_user, @course
    current_user.done_task task_progress
    redirect_to course_subject_path @course, @subject
  end
end
