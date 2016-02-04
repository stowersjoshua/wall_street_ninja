class SalesController < ApplicationController
	before_action :authenticate_user!

	def new
		@purchase = Purchase.find(params[:purchase_id])
		@company = Company.find(params[:company_id])
	end

	def create
		@portfolio = current_user.active_portfolio
		@company = Company.find(params[:company_id])
		# response = QuandlService::Quandl.get_quandl_data(@company.id, 1)
   	@price = @company.current_price
   	purchase = Purchase.find(params[:purchase_id])

   	sale = Sale.new(sale_permitted_params)
   	if sale.save!
			balance = (current_user.total_balance + sale.total_price)
			current_user.update_attributes(total_balance: balance)
			@portfolio.update_purchase(purchase, sale.quantity)
   		flash[:notice] = "Stocks sold successfully"
   	end
   	redirect_to :back
	end

	private
	def sale_permitted_params
		params[:sale][:portfolio_id] = @portfolio.id
		params[:sale][:price] = @price
		params[:sale][:total_price] = params[:sale][:quantity].to_i * @price 
		params.require(:sale).permit!
	end
end