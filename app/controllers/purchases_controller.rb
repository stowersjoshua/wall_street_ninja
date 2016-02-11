# rubocop:disable Metrics/AbcSize
class PurchasesController < ApplicationController
  before_action :authenticate_user!

  def new
    @company = Company.find(params[:company_id])
  end

  def create
    @company = Company.find(params[:company_id])
    @price = @company.current_price
    purchase = Purchase.new(purchase_permitted_params)
    if purchase.total_price.to_f < current_user.total_balance.to_f
      purchase.save
      current_user.update_total_balance(purchase)
      flash[:notice] = 'Stock purchased successfully'
      path = companies_path
    else
      flash[:notice] = 'You have not sufficient money to purchase the stock.'
      path = :back
    end
    redirect_to path
  end

  private

  def purchase_permitted_params
    params[:purchase][:company_id] = @company.id
    params[:purchase][:portfolio_id] = current_user.active_portfolio.id
    params[:purchase][:price] = @price
    params[:purchase][:total_price] = params[:purchase][:quantity].to_i * @price
    params.require(:purchase).permit!
  end
end
