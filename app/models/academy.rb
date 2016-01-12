class Academy < ActiveRecord::Base
	# has_many :subscriptions, dependent: :destroy
	# has_many :institutions, through: :subscriptions
	has_one :subscription, dependent: :destroy
	has_one :institution, through: :subscription

	validates_uniqueness_of :name
	accepts_nested_attributes_for :subscription, allow_destroy: true
end