class SalesController < ApplicationController
	include HTTParty
	before_action :authenticate_user!
	
	def index
		@portfolio = current_user.active_portfolio
	end

	def fetch_share_quantity
		portfolio = current_user.active_portfolio
		company = portfolio.companies.find(params[:company_id])
		@no_of_shares = company.stocks.where(portfolio_id: portfolio.id).sum(:quantity)
	end

	def sale_shares
		portfolio = current_user.active_portfolio
		company = Company.find(params[:company])
		token = Rails.application.secrets.quandl_token
		url = Rails.application.secrets.quandl_url
		response = HTTParty.get("#{url}#{company.free_code}.json?token=#{token}&rows=1&column_index=4")
		price = response["dataset"]["data"][0][1]
		balance = (current_user.total_balance + (params[:no_of_shares].to_i * price))
		current_user.update_attributes(total_balance: balance)
	end
end
