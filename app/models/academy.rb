class Academy < ActiveRecord::Base
	has_one :subscription, dependent: :destroy
	has_one :institution, through: :subscription
	has_many :registrations, dependent: :destroy
	has_many :standards, through: :registrations

	validates_uniqueness_of :name
	accepts_nested_attributes_for :subscription, allow_destroy: true
end