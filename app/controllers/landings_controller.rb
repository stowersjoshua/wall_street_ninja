class LandingsController < ApplicationController
  
  def index
    @data = []
    if current_user.present?
      if current_user.is_standard_user?
        unless current_user.first_name.present?
          redirect_to user_profile_users_path
        else 
          @active_portfolio = current_user.active_portfolio
          @data = current_user.fetch_quandl_data(@active_portfolio)
          @academies = current_user.registrations.where(status: "approve").map(&:academy).flatten
          @assignments = @academies.map(&:assignments).flatten
        end
      elsif current_user.is_institution_user?
        @owned_academies = current_user.academies
        @mod_academies = current_user.institution_registered_academies
        @student_requests = current_user.registrations.where(reg_type: "Standard", status: "pending")
        @moderator_requests = current_user.registrations.where(reg_type: "Institution", status: "pending")
        @assignments = current_user.academies.map(&:assignments).flatten
        @moderator_assignments = current_user.institution_registered_academies.map(&:assignments).flatten
      end
    end
  end

  def search
    if params[:category] == "Company"
      path = companies_path(search: params[:search], category: params[:category])
    elsif params[:category] == "Academy"
      path = academies_path(search: params[:search], category: params[:category])
    elsif params[:category] == "Article"
      path = articles_path(search: params[:search], category: params[:category])
    end
    redirect_to path
  end
end
