class Payment < ActiveRecord::Base
	belongs_to :user

	validates :amount, :status, :transaction_id, :plan_id, :subscription_id, presence: true
end
