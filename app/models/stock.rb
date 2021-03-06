class Stock < ActiveRecord::Base # :nodoc:
  belongs_to :portfolio
  belongs_to :company
  validates :quantity, :price, :total_price, :type, presence: true
end
