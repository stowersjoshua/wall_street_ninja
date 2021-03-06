class ArticlesController < ApplicationController # :nodoc:
  before_action :authenticate_user!

  def index
    if params[:search].present?
      search = params[:search].downcase
      @articles = Article.where('lower(title) LIKE ? OR lower(summary) LIKE ?',
                                "%#{search}%", "%#{search}%")
    else
      @articles = Article.all
    end
  end

  def show
    @article = Article.find(params[:id])
    if params[:read].present? 
    end
  end
end
