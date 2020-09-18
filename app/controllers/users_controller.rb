class UsersController < ApplicationController
	def index
		@performers = User.all
	end
	
	def show
		@performer = User.find(params[:id])
		@auditions = Audition.where(user_id: @performer.id)
	end
	
	def edit
		@performer = User.find(params[:id])
	end
	
	def update
		@performer = User.find(params[:id])
		@performer.update(performer_params)
		redirect_to performer_path
	end

  def show
    @performer = User.find(params[:id])
    authorize @performer
  end

  def edit
    @performer = User.find(params[:id])
    authorize @performer
  end

  def update
    @performer = User.find(params[:id])
    authorize @performer
    @performer.update(performer_params)
    redirect_to performer_path
  end

  private

  def performer_params
    params.require(:user).permit(:name, :gender, :ethniciy, :email, :age, :location, :physical_attributes, :bio)
  end
end
