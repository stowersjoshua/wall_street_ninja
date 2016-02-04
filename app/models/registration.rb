class Registration < ActiveRecord::Base
	belongs_to :user
	belongs_to :academy

	validates :user_id, :reg_type, presence: true
end
