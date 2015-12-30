class LandingsController < ApplicationController
	before_action :authenticate_user!, except: [:index]
  
  def index
    if current_user.present?
      @portfolios = current_user.portfolios.where(active: false)
    end
  end

  # def companies
  # 	@companies = Company.all
  # end

  def company_details
  	@company = Company.find(params[:id])
  	token = Rails.application.secrets.quandl_token
		url = Rails.application.secrets.quandl_url
		response = HTTParty.get("#{url}#{@company.free_code}.json?token=#{token}&rows=10")
		@company_details = response["dataset"]
  end
end
