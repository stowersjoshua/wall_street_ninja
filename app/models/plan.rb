class Plan < ActiveRecord::Base
	has_many :subscriptions, dependent: :destroy
end
