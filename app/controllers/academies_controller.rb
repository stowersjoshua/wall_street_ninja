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

	def academies_lists
		@academies = Academy.all
	end

	def send_joining_request
		academy = Academy.find(params[:id])
		registration = Registration.create(standard_id: current_user.id, academy_id: academy.id) 
		UserMailer.registration_request(registration).deliver
		flash[:notice] = "Your request delivered successfully"
		redirect_to :back
	end

	def registration_list
		if current_user.is_institution_user?
			academies = current_user.academies
			@registrations = academies.map(&:registrations).flatten.sort_by{|e| e[:created_at]}.reverse
		else
			flash[:notice] = "Please login as Insitutional User."
			redirect_to root_path
		end
	end

	def approve_registration_request
		registration = Registration.find(params[:id])
		registration.status = "approve"
		registration.save
		registration_list
		flash[:message] = "Registration request approved successfully"
	end

	def remove_registration_request
		registration = Registration.find(params[:id])
		registration.destroy
		registration_list
		flash[:message] = "Registration request rejected successfully"
	end

	def search
		search = params[:search].downcase
    @academies = Academy.where("lower(name) LIKE ? OR lower(description) LIKE ?", "%#{search}%", "%#{search}%")
	end

	private
	def academy_permitted_params
		params.require(:academy).permit!
	end
end
