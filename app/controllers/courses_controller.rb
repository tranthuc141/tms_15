class CoursesController < ApplicationController
  def show
  end

  def index
    @courses = Course.all
  end

  def new
  end

  def edit
  end
end
