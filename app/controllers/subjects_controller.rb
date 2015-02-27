class SubjectsController < ApplicationController
  def show
    @subject = Subject.find params[:id]
    @tasks = @subject.tasks
    @task = Task.new
  end

  def index
    @subjects = Subject.paginate page: params[:page]
  end

  def new
    @subject = Subject.new
    4.times{@task = @subject.tasks.build}
  end

  def addtask
    @task = Task.new
    @subject = Subject.find params[:subject_id]
    @tasks = @subject.tasks
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
