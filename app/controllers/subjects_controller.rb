class SubjectsController < ApplicationController
  def show
    @subject = Subject.find params[:id]
    @course = Course.find params[:course_id]
    @training_progress = TrainingProgress.find_by course_id: @course.id,
      user_id: current_user.id
    @subject_progress = SubjectProgress.find_by training_progress_id: @training_progress.id,
      subject_id: @subject.id
    @tasks = @subject.tasks
  end

  def index
    @subjects = Subject.paginate page: params[:page]
  end

  def new
    @subject = Subject.new
    4.times{@task = @subject.tasks.build}
  end

  def create
    @subject = Subject.new subject_params
    if @subject.save
      flash[:success] = "Create subject successfully!"
      redirect_to subjects_path
    else
      render 'new'
    end   
  end

  def edit
  end

  private
  def subject_params
    params.require(:subject).permit :name, :description,
      :tasks_attributes => [:id, :description]
  end
end
