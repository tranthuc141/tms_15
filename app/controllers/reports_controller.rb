class ReportsController < ApplicationController
  def new
    @report = current_user.reports.build
  end

  def create
    @report = current_user.reports.build report_params
    if @report.save
      flash[:success] = "Success report at #{Time.now}!"
      redirect_to root_url
    else
      render 'static_pages/home'
    end
  end

  private
  def report_params
    params.require(:report).permit :content
  end
end
