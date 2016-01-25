class UsersController < ApplicationController
	before_action :authenticate_user!

	def user_profile
    @user = current_user
  end

  def update
  	user = User.find(params[:id])
  	if user.update_attributes(standard_permitted_params)
      Portfolio.create(user_id: user.id, active: true, name: "primary") unless user.active_portfolio.present?
  		flash[:notice] = "Signup process completed successfully"	
  		redirect_to root_path
  	else
  		flash[:notice] = user.errors.full_messages.first
  		redirect_to :back
  	end
  end

  private
	def standard_permitted_params
		params.require(:standard).permit!
	end
end
