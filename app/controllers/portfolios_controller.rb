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
		if params[:portfolio][:balance].to_i < current_user.total_balance
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
	end

	private
	def portfolio_permitted_params
		params[:portfolio][:user_id] = current_user.id
		params.require(:portfolio).permit!
	end
end
