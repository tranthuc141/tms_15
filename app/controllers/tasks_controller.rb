class TasksController < ApplicationController
  respond_to :html, :js
  
  def index
  end

  def show
    @task = Task.find params[:id]
  end

  def update
    @task = Task.find params[:id]
    @task.update_attributes task_params
    redirect_to subject_path @task.subject
  end

  private
  def task_params
    params.require(:task).permit :name, :description, :subject_id
  end
end
