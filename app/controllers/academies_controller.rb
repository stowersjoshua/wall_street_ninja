class AcademiesController < ApplicationController
	before_action :authenticate_user!

	def index
		@academies = current_user.academies
	end

	def new
		@academy = Academy.new
		@academy.build_subscription
	end

	def create
		academy = Academy.new(academy_permitted_params)
		if academy.save
			msg = "Academy created successfully."
			path = academies_path
		else
			msg = academy.errors.full_messages.first
			path = :back
		end
		flash[:notice] = msg
		redirect_to path
	end

	private
	def academy_permitted_params
		params.require(:academy).permit!
	end
end
