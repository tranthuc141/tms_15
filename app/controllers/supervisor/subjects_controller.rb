class Supervisor::SubjectsController < ApplicationController
  before_action :supervisor

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
      redirect_to supervisor_subjects_path
    else
      render 'new'
    end 
  end

  def show
    @subject = Subject.find params[:id]
    @tasks = @subject.tasks
    @task = Task.new
  end

  def edit
    @subject = Subject.find params[:id]
  end

  def update
    @subject = Subject.find params[:id]
    @subject.update_attributes subject_params
    redirect_to supervisor_subject_path @subject
  end

  def destroy
    @subject = Subject.find params[:id]
    @subject.destroy
    flash[:success] = "Subject deleted"
    redirect_to supervisor_subjetcs_path
  end

  private
  def subject_params
    params.require(:subject).permit :name, :description, :course_id,
      :tasks_attributes => [:id, :description]
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
