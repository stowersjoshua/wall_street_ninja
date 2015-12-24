class Company < ActiveRecord::Base
	has_many :stocks, dependent: :destroy
	validates :cik_id, :sic_code, :name, :description, :city, :state, presence: true
end
