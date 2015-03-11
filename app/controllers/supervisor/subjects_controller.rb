class Supervisor::SubjectsController < ApplicationController
  before_action :supervisor

  def index
    @subjects = Subject.paginate page: params[:page]
  end

  def new
    @subject = Subject.new
  end

  def create
    @subject = Subject.new subject_params
    if @subject.save
      flash[:success] = "Create subject successfully!"
      redirect_to supervisor_subject_path @subject
    else
      render 'new'
    end 
  end

  def show
    if params[:course_id] 
      @course = Course.find(params[:course_id])
      unless @subject = @course.subjects.find_by(id: params[:id])
        flash[:notice] = "Not found subject #{params[:id]} in this course"
        redirect_to [:supervisor, @course]
        return
      end
    else
      @subject = Subject.find params[:id]
    end
    @subject_progresses = @subject.subject_progresses
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
