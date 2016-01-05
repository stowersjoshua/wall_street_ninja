class Sale < Stock
	after_create :destroy_purchase

	def destroy_purchase
		active_portfolio = self.portfolio
		purchases = portfolio.purchases.where(quantity: 0)
		purchases.destroy_all
	end
end
