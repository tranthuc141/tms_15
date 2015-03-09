class TrainingProgressesController < ApplicationController
  before_action :supervisor

  def new
    @course = Course.find params[:course_id]
    current_user.start_course @course
  end

  def show
    @course = Course.find params[:course_id]
    @users = User.all
  end

  def update
    @course = Course.find params[:course_id]
    if @course.update_attributes training_progresses_params
      @training_progresses = @course.training_progresses
      current_user.update_progress_info @training_progresses
      flash[:success] = "Added users to course."
      redirect_to supervisor_course_path @course
    else
      flash[:error] = "Cannot add user to course."
      redirect_to course_training_progresses_path @course
    end
  end

  def destroy
    @course = Course.find params[:course_id]
    current_user.finish_course @course
  end

  private
  def training_progresses_params
    params.require(:course).permit user_ids: []
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
