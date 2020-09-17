class RolesController < ApplicationController
  def new
    @role = Role.new
    @job = Job.find(params[:job_id])
  end

  def create
    @role = Role.new(role_params)
    @job = Job.find(params[:job_id])
    @role.job = @job

    if @role.save
      redirect_to @job
    else
      render :new
    end
  end

  private

  def role_params
    params.require(:role).permit(:title, :description)
  end
end
