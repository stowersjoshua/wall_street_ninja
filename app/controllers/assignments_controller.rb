class AssignmentsController < ApplicationController # :nodoc:
  before_action :authenticate_user!

  def new
    @academy = Academy.find(params[:academy_id])
    @assignment = Assignment.new
  end

  def create
    assignment = Assignment.new(assignment_permitted_params)
    article_ids =  params[:assignment][:article_ids].reject { |c| c.empty? }
    if assignment.save
      msg = 'Assignment created successfully.'
      path = root_path
    else
      msg = assignment.errors.full_messages.first
      path = :back
    end
    flash[:notice] = msg
    redirect_to path
  end

  def edit
    @academy = Academy.find(params[:academy_id])
    @assignment = Assignment.find(params[:id])
  end

  def update
    @assignment = Assignment.find(params[:id])
    if @assignment.update_attributes(assignment_permitted_params)
      flash[:notice] = "Assignment updated succesfully"
      redirect_to root_path
    else
      redirect_to :back
    end
  end

  def show
    @assignment = Assignment.find(params[:id])
    @articles = @assignment.articles if @assignment.assignment_type == "Reading"
  end

  private

  def assignment_permitted_params
    params[:assignment][:academy_id] = params[:academy_id]
    params.require(:assignment).permit!
  end
end
