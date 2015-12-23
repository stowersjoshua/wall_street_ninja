class Company < ActiveRecord::Base
	belongs_to :stock
	validates :stock_id, :cik_id, :sic_code, :name, :description, :city, :state, presence: true
end
