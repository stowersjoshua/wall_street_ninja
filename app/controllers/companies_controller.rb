class CompaniesController < ApplicationController
	before_action :authenticate_user!

	def index
    if params[:search].present?
  	  search = params[:search].downcase
      @companies = Company.where("lower(name) LIKE ? OR lower(city) LIKE ? OR lower(state) LIKE ?", "%#{search}%", "%#{search}%", "%#{search}%")
    else
     @companies = Company.all
    end
  end

  def show
  	@company = Company.find(params[:id])
    response = QuandlService::Quandl.get_quandl_data(@company.id, 10)
		@company_details = response["dataset"]
  end
end