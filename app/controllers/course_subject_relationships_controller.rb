class CourseSubjectRelationshipsController < ApplicationController
  def show
    @course = Course.find params[:course_id]
    @subjects = Subject.all
  end

  def update
    @course = Course.find params[:course_id]
    if @course.update_attributes course_subject_relationship_params
      flash[:success] = "Added subjects to course."
      redirect_to course_path @course
    else
      flash[:error] = "Cannot add subjects to course."
      redirect_to course_course_subject_relationships_path @course
    end
  end

  private
  def course_subject_relationship_params
    params.require(:course).permit subject_ids: []
  end
end
