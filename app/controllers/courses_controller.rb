class CoursesController < ApplicationController
  def show
  end

  def index
    @courses = Course.paginate page: params[:page]
  end

  def new
  end

  def edit
  end
end
