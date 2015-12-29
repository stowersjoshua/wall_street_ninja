class LandingsController < ApplicationController
	before_action :authenticate_user!, except: [:index]
  
  def index
  end

  def companies
  end

  def company_details
  end
end
