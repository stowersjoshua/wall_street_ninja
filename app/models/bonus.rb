class Bonus < ActiveRecord::Base
	belongs_to :portfolio
	validates :amount, :description, :portfolio_id, presence: true
end
