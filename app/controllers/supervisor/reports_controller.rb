class Supervisor::ReportsController < ApplicationController

  def index

  end

  def create
    t = params[:session][:user_id]
    @report_list = Report.where user_id: t
  end
end
