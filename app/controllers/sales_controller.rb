class SalesController < ApplicationController
	before_action :authenticate_user!
	
	def index
		@portfolio = current_user.active_portfolio
		if @portfolio.present?
			@companies = @portfolio.companies.present? ? @portfolio.companies.map{|c| [c.name, c.id]} : [] 
			@sales = @portfolio.sales
		else
			@companies = []
			@sales = []
		end
	end

	def fetch_share_quantity
		portfolio = current_user.active_portfolio
		company = portfolio.companies.find(params[:company_id])
		@no_of_shares = portfolio.purchases.where(company_id: company.id).sum(:quantity)
	end

	def sale_shares
		total_shares = params[:no_of_shares].to_i
		portfolio = current_user.active_portfolio
		company = Company.find(params[:company])
		response = QuandlService::Quandl.get_quandl_data(company.id, 1)
		price = response["dataset"]["data"][0][4]
		
		total_price = (total_shares * price)
		balance = (current_user.total_balance + total_price)
		
		current_user.update_attributes(total_balance: balance)
		portfolio.update_purchase_quantity(company.id, total_shares)
		Sale.create(company_id: company.id, portfolio_id: portfolio.id, quantity: total_shares, price: price, total_price: total_price)
		flash[:notice] = "Share sale successfully"
		redirect_to sales_path
	end
end