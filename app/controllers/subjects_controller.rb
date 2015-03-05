class SubjectsController < ApplicationController
  def show
    @subject = Subject.find params[:id]
    @tasks = @subject.tasks
    @task = Task.new
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
