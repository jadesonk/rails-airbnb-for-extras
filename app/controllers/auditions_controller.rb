class AuditionsController < ApplicationController
	include Devise::Controllers::Helpers

	def new
		@audition = Audition.new
		@role = Role.find(params[:role_id])
	end

	def create
		@audition = Audition.new(audition_params)
		@role = Role.find(params[:role_id])
		@audition.role = @role
		@user = current_user
		@audition.user = @user
    @audition.status = "pending"

		if @audition.save
			redirect_to root_path
		else
			render :new
		end
	end

  def approve
    @audition = Audition.find(params[:id])
    @audition.status = "approve"
    @audition.save
    redirect_to root_path
  end



	private

	def audition_params
		params.require(:audition).permit(:application_details)
	end
end
