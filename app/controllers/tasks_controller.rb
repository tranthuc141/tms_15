class TasksController < ApplicationController
  respond_to :html, :js
  def index
  end

  def new
    @task = Task.new
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
    redirect_to subject_path(@task.subject)
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
end
