class JobsController < ApplicationController
  def index
    @jobs = Job.all
  end

  def show
    @job = Job.find(params[:id])
  end

  def new
    @job = Job.new
  end

  def create
    @job = Job.new(job_params)
    @job.user = current_user

    if @job.save
      redirect_to @job
    else
      render :new
    end
  end

  private

  def job_params
    params.require(:job).permit(:title, :description, :location, :application_deadline_date, :shoot_date)
  end
end
