class UsersController < ApplicationController
	def index
		@performers = User.all
	end

	def show
		@performer = User.find(params[:id])
	end

end
