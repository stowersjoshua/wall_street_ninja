class AcademiesController < ApplicationController
	before_action :authenticate_user!

	def index
		if params[:search].present?
  	  search = params[:search].downcase
      @academies = Academy.where("lower(name) LIKE ? OR lower(description) LIKE ?", "%#{search}%", "%#{search}%")
    else
			@academies = Academy.all
		end
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

	def show
		@academy = Academy.find(params[:id])
	end
	
	def update
		academy = Academy.find(params[:id])
		if academy.update_attributes(academy_permitted_params)
			msg = "Academy information updated successfully."
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
		registration = Registration.create(user_id: current_user.id, academy_id: academy.id, reg_type: current_user.type) 
		if current_user.is_institution_user?
			UserMailer.moderator_registration_request(registration).deliver
		else
			UserMailer.registration_request(registration).deliver
		end
		flash[:notice] = "Your request delivered successfully"
		redirect_to :back
	end

	def registration_list
		if current_user.is_institution_user?
			@standard_registrations = current_user.academies.map(&:registrations).flatten.select{|reg| reg.reg_type == "Standard"}.sort_by{|e| e[:created_at]}.reverse
			@institution_registrations = current_user.academies.map(&:registrations).flatten.select{|reg| reg.reg_type == "Institution"}.sort_by{|e| e[:created_at]}.reverse
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

	private
	def academy_permitted_params
		params.require(:academy).permit!
	end
end
