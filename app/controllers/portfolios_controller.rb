class PortfoliosController < ApplicationController # :nodoc:
  before_action :authenticate_user!

  def index
    @active_portfolio = current_user.active_portfolio
    @data = current_user.fetch_quandl_data(@active_portfolio)
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
