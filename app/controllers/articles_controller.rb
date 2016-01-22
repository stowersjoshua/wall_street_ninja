class ArticlesController < ApplicationController
	before_action :authenticate_user!

	def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def search
    search = params[:search]
    @articles = Article.where("title LIKE ? OR summary LIKE ?", "%#{search}%", "%#{search}%")
  end 
end
