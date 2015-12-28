class PortfoliosController < ApplicationController
	before_action :authenticate_user!
	
	def index
		@portfolios = Portfolio.all
	end

	def new
		@portfolio = Portfolio.new
		@portfolio.stocks.build unless @portfolio.stocks.present?
	end

	def create
		binding.pry
		if params[:Portfolio][:balance] < current_user.total_balance
			portfolio = Portfolio.create(portfolio_permitted_params)
		else
			flash[:notice] = "You have not money"
		end
		redirect_to portfolios_path
	end

	def fetch_current_price
	end

	private
	def portfolio_permitted_params
		params[:portfolio][:user_id] = current_user.id
		params.require(:portfolio).permit!
	end
end
