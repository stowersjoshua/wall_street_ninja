class LandingsController < ApplicationController
	before_action :authenticate_user!, except: [:index]
  
  def index
    @data = []
    if current_user.present?
      if current_user.is_standard_user? 
        @portfolios = current_user.portfolios.where(active: false)
        @active_portfolio = current_user.active_portfolio
        if @active_portfolio.present?
          purchases = @active_portfolio.purchases 
          if purchases.present?
            purchases.each do |p|
              api_data = QuandlService::Quandl.get_quandl_data(p.company.id, 1)
              live_price = api_data["dataset"]["data"][0][4]
              latest_amount = (p.quantity * live_price).round(2)
              data = {}
              data[:company_id] = p.company.id
              data[:company_name] = p.company.name
              data[:live_price] = live_price
              data[:quantity] = p.quantity
              data[:inv_price] = p.price 
              data[:inv_amount] = p.total_price
              data[:lat_value] = latest_amount
              data[:overall_gain] = (latest_amount - p.total_price).round(2)
              data[:inv_date] = p.created_at.strftime("%d/%m/%Y")
              @data << data
            end
          end
        end
      else
        redirect_to academies_path
      end
    end
  end

  def companies
  	@companies = Company.all
  end

  def company_details
  	@company = Company.find(params[:id])
    response = QuandlService::Quandl.get_quandl_data(@company.id, 10)
		@company_details = response["dataset"]
  end

  def learning_lounge
    @articles = Article.all
  end

  def learning_lounge_detail
    @article = Article.find(params[:id])
  end

  def article_search
    search = params[:search]
    @articles = Article.where("title LIKE ? OR summary LIKE ?", "%#{search}%", "%#{search}%")
  end 
end
