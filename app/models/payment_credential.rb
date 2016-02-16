class PaymentCredential < ActiveRecord::Base
	belongs_to :user
	validates :customer_id, :user_id, :plan_id, :last4, :exp_date, :first_name, :last_name, :pin_code, :email, :phone_number, presence: true
end
