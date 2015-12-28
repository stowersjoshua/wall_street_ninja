class Company < ActiveRecord::Base
	# belongs_to :portfolio
	has_many :stocks, dependent: :destroy
	
	validates :cik_code, :sic_code, :name, :description, :city, :state, presence: true
end
