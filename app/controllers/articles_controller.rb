class ArticlesController < ApplicationController
	before_action :authenticate_user!

	def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def search
    search = params[:search].downcase
    @articles = Article.where("lower(title) LIKE ? OR lower(summary) LIKE ?", "%#{search}%", "%#{search}%")
  end 
end
