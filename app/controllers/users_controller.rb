class UsersController < ApplicationController
	def index
		@performers = User.all
		raise
	end
end
