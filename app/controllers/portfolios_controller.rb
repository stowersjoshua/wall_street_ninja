class PortfoliosController < ApplicationController
	before_action :authenticate_user!
	
	def index
		portfolio = current_user.active_portfolio
		@purchases = portfolio.purchases
	end

	def new
		@portfolio = Portfolio.new
		@portfolio.purchases.build unless @portfolio.purchases.present?
	end

	def create
		if params[:portfolio][:balance].to_f < current_user.total_balance.to_f
			portfolio = Portfolio.create(portfolio_permitted_params)
			current_user.total_balance -= portfolio.balance
			current_user.save
			path = portfolios_path
		else
			flash[:notice] = "You have not money"
			path = :back
		end
		redirect_to path
	end

	def edit
		@portfolio = Portfolio.find(params[:id])
		render :new
	end

	def update
		portfolio = Portfolio.find(params[:id])
		if portfolio.update_attributes(portfolio_permitted_params)
			flash[:notice] = "Saved successfully"
			path = portfolios_path
		else
			flash[:notice] = "something going wrong"
			path = :back
		end
		redirect_to path
	end

	def destroy
		portfolio = Portfolio.find(params[:id])
		portfolio.destroy
		redirect_to portfolios_path
	end

	def fetch_current_price
		company = Company.find(params[:id])
		response = QuandlService::Quandl.get_quandl_data(company.id, 1)
		@price = response["dataset"]["data"][0][4]
	end

	def change_status
		portfolio = Portfolio.find(params[:id])
		current_user.portfolios.update_all(active: false)
		if portfolio.update_attributes(active: true)
			@portfolios = current_user.portfolios
			flash[:notice] = "Portfolio status change successfully."
		end
	end

	def companies
		@companies = Company.all
	end

	def company_details
		@company = Company.find(params[:id])
	end

	private
	def portfolio_permitted_params
		params[:portfolio][:user_id] = current_user.id
		params.require(:portfolio).permit!
	end
end
