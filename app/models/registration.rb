class Registration < ActiveRecord::Base
	belongs_to :standard
	belongs_to :academy

	validates :standard_id, presence: true
end
