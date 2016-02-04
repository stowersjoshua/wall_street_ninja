class AssignmentsController < ApplicationController
	before_action :authenticate_user!

	def new
		@academy = Academy.find(params[:academy_id])
		@assignment = Assignment.new
	end

	def create
		assignment = Assignment.new(assignment_permitted_params)
		if assignment.save
			msg = "Assignment created successfully."
			path = root_path
		else
			msg = assignment.errors.full_messages.first
			path = :back
		end
		flash[:notice] = msg
		redirect_to path
	end

	private
	def assignment_permitted_params
		params[:assignment][:academy_id] = params[:academy_id]
		params.require(:assignment).permit!
	end
end
