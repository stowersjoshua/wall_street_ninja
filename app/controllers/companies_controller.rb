class CompaniesController < ApplicationController
	before_action :authenticate_user!

	def index
  	@companies = Company.all
  end

  def show
  	@company = Company.find(params[:id])
    response = QuandlService::Quandl.get_quandl_data(@company.id, 10)
		@company_details = response["dataset"]
  end

  def search
  	search = params[:search].downcase
    @companies = Company.where("lower(name) LIKE ? OR lower(city) LIKE ? OR lower(state) LIKE ?", "%#{search}%", "%#{search}%", "%#{search}%")
  end

  def purchase
    @portfolio = current_user.active_portfolio
    @company = Company.find(params[:id])
    response = QuandlService::Quandl.get_quandl_data(@company.id, 1)
    @price = response["dataset"]["data"][0][4]
  end

  def create_purchase
    purchase = Purchase.new(purchase_permitted_params)
    if purchase.total_price.to_f < current_user.total_balance.to_f 
      purchase.save
      current_user.update_total_balance(purchase)
      flash[:notice] = "Saved successfully"
      path = companies_path
    else
      flash[:notice] = "something going wrong"
      path = :back
    end
    redirect_to path
  end

  private
  def purchase_permitted_params
    params.require(:purchase).permit!
  end
end