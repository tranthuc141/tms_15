class SubjectsController < ApplicationController
  def show
    if params[:course_id] 
      @course = Course.find(params[:course_id])
      unless @subject = @course.subjects.find_by(id: params[:id])
        flash[:notice] = "Not found subject #{params[:id]} in this course"
        redirect_to @course
        return
      end
    else
      @subject = Subject.find params[:id]
    end
    training_progress = TrainingProgress.find_by user_id: current_user.id,
      course_id: @course.id
    @subject_progress = SubjectProgress.find_by training_progress_id: training_progress.id,
      subject_id: @subject.id
    @tasks = @subject.tasks
  end

  def index
    @subjects = Subject.paginate page: params[:page]
  end

  private
  def subject_params
    params.require(:subject).permit :name, :description,
      :tasks_attributes => [:id, :description]
  end
end
