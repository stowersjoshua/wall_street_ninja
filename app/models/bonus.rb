class Bonus < ActiveRecord::Base
	belongs_to :portfolio, class_name: 'Portfolio'
	validates :amount, :description, :portfolio_id, presence: true
end
