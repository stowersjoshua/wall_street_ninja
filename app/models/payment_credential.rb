class PaymentCredential < ActiveRecord::Base
	belongs_to :user
	validates :customer_id, :user_id, :plan_id, :last4, :exp_date, :first_name, :last_name, :pincode, :email, :phone_number, presence: true
end
