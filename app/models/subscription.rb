class Subscription < ActiveRecord::Base
	belongs_to :institution
	belongs_to :academy
	belongs_to :plan

	validates :institution_id, :plan_id, presence: true
end
