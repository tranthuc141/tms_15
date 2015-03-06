class Supervisor::TasksController < ApplicationController
  before_action :supervisor

  def new
    @task = Task.new
    @subject = Subject.find params[:subject_id]
  end

  def edit
    @task = Task.find params[:id]
  end

  def show
    @task = Task.find params[:id]
  end

  def update
    @task = Task.find params[:id]
    @task.update_attributes task_params
    redirect_to subject_path @task.subject
  end

  def create
    @task = Task.new task_params
    @task.save
    redirect_to supervisor_subject_path @task.subject
  end

  def destroy
    @task = Task.find params[:id]
    @subject = @task.subject
    @task.destroy
    redirect_to subject_path @subject
  end

  private
  def task_params
    params.require(:task).permit :name, :description, :subject_id
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
