class TrainingProgressesController < ApplicationController
  def show
    @course = Course.find params[:course_id]
    @users = User.all
  end

  def update
    @course = Course.find params[:course_id]
    if @course.update_attributes training_progresses_params
      flash[:success] = "Added users to course."
      redirect_to course_path @course
    else
      flash[:error] = "Cannot add user to course."
      redirect_to course_training_progresses_path @course
    end
  end

  private
  def training_progresses_params
    params.require(:course).permit user_ids: []
  end
end
