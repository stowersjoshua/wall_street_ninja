class PaymentsController < ApplicationController # :nodoc:
	before_action :authenticate_user!

	def new_payment
		@user = current_user
		@user.payment_credentials.build
		@academy = Academy.new(academy_permitted_params)
	end

	def create
		plan_id = params[:institution][:academies_attributes]["0"][:subscription_attributes][:plan_id]
		@plan = Plan.find(plan_id)
		product_handle = @plan.plan_handler
		@subscription = Chargify::Subscription.create(
          :product_handle => product_handle,
          :customer_attributes => {
            :first_name => params[:institution][:payment_credentials_attributes]["0"][:first_name],
            :last_name => params[:institution][:payment_credentials_attributes]["0"][:last_name],
            :email => params[:institution][:payment_credentials_attributes]["0"][:email],
          },
          :credit_card_attributes => {
            :expiration_month => params[:institution][:payment_credentials_attributes]["0"]['exp_date(2i)'],
            :expiration_year => params[:institution][:payment_credentials_attributes]["0"]['exp_date(1i)'],
            :full_number => params[:institution][:payment_credentials_attributes]["0"][:last4]
          }
        )
		if @subscription.save
			current_user.update_attributes!(academies_permitted_params)
			amount = @subscription.product.price_in_cents / 100
			Payment.create(user_id: current_user.id, plan_id: @plan.id, amount: amount, transaction_id: @subscription.signup_payment_id, subscription_id: @subscription.id)
			flash[:notice] = "Academy created successfully"
		else
			flash[:notice] = @subscription.errors.messages
    end
			redirect_to academies_path
	end

	private
	def academies_permitted_params
		params[:institution][:payment_credentials_attributes]["0"][:last4] = params[:institution][:payment_credentials_attributes]["0"][:last4].to_s.last(4)
		params[:institution][:payment_credentials_attributes]["0"][:user_id] = current_user.id
		params[:institution][:payment_credentials_attributes]["0"][:plan_id] = @plan.id
		params[:institution][:payment_credentials_attributes]["0"][:customer_id] = @subscription.customer.id
		params.require(:institution).permit!
	end

	def academy_permitted_params
		params.require(:academy).permit!
	end
end
