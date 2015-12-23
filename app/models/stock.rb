class Stock < ActiveRecord::Base
	belongs_to :portfolio
	has_one :company, dependent: :destroy
	validates :quantity, :price, :total_price, :type, :portfolio_id, presence: true
end
