class PaymentsController < ApplicationController # :nodoc:
	before_action :authenticate_user!

	def new_payment
		@payment = Payment.new
		@user = current_user
		@academy_name = params[:academy][:name]
		@plan = params[:academy][:subscription_attributes][:plan_id]
		@description = params[:academy][:description]
	end

	def create
		binding.pry
		product_handle = "test"
		@subscription = Chargify::Subscription.create(
          :product_handle => 'test',
          :customer_attributes => {
            :first_name => params[:institution][:payment_credential][:first_name],
            :last_name => params[:institution][:payment_credential][:last_name],
            :email => params[:institution][:payment_credential][:email],
          },
          :credit_card_attributes => {
            :expiration_month => params[:institution][:payment_credential]['exp_date(2i)'],
            :expiration_year => params[:institution][:payment_credential]['exp_date(1i)'],
            :full_number => params[:institution][:payment_credential][:last4]
          }
        )
 #    if @subscription.save
 #      json_object = @subscription.attributes.to_json
 #      parsed_json = JSON.parse(json_object)
 #      subscription_id = parsed_json['id']
 #      session[:subscription_id] = subscription_id;
 #      @payment.update_attributes(:subscription_id => subscription_id)
 #      format.html { redirect_to "/payment/index", notice: 'Payment was successfully created.' }
 #    else
 #      messages ="";
 #      @subscription.errors.full_messages.each {|error| messages += error + "<br />"} 
 #      puts "Subscription Failed!" + messages
 #      format.html {  render action: "new" }
 #    end
	end
end
